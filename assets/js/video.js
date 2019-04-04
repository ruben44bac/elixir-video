import Player from './algo';

let Video = {
    init(socket, element) {
        if(!element){return}
        let playerId = element.getAttribute("data-algo")
        let videoId = element.getAttribute("data-id")
        socket.connect()
        Player.init(element.id, playerId, () => {
            this.onReady(videoId, socket)
        })
    },

    onReady(videoId, socket){
        let msgContainer    =   document.getElementById("msg-container")
        let msgInput    =   document.getElementById("msg-input")
        let postButton    =   document.getElementById("msg-submit")
        let lastSeenId = 0
        let vidChannel    =   socket.channel("videos:" + videoId, () => {
          return {last_seen_id: lastSeenId}  
        })


        postButton.addEventListener("click", e => {
            let payload = {body: msgInput.value, at: Player.getCurrentTime()}
            vidChannel.push("new_annotation", payload)
                .receive("error", e => console.log(e))
            msgInput.value = ""
        })

        msgContainer.addEventListener("click", e => {
            e.preventDefault()
            let segundo = e.target.getAttribute("data-seek") || e.target.parentNode.getAttribute("data-seek")

            if(!segundo){ return }
            Player.seekTo(segundo)
        })

        vidChannel.on("new_annotation", (resp) => {
            lastSeenId = resp.id
            this.muestraComentario(msgContainer, resp)
        })

        vidChannel.join()
            .receive("ok", resp => {
                /*resp.comentarios.forEach(
                    com => {
                        this.muestraComentario(msgContainer, com)
                    })*/
                let ids = resp.comentarios.map(com => com.id)
                if(ids.length > 0){ lastSeenId = Math.max(...ids)}
                this.ordenarMensaje(msgContainer, resp.comentarios)
                
            })
            .receive("error"), resp => console.log("ERROR FATAL", resp)
    },
    esc(str){
        let div = document.createElement("div")
        div.appendChild(document.createTextNode(str))
        return div.innerHTML
    },
    muestraComentario(msgContainer, {usuario, body, at}){
        let template = document.createElement("div")
        template.className = window.name == usuario.nombre_usuario ? "mensaje-detalle-propio" : "mensaje-detalle"
        template.innerHTML = `
            <a href="# data-seek="${this.esc(at)}">
                [${this.formatoTiempo(at)}]
                <b>${ this.esc(usuario.nombre_usuario)}</b>: ${ this.esc(body) }
            </a>
        `
        msgContainer.appendChild(template)
        msgContainer.scrollTop = msgContainer.scrollHeight

    },
    ordenarMensaje(msgContainer, comentarios){
        clearTimeout(this.ordenarTiempo)
        this.ordenarTiempo = setTimeout(() => {
            let ctime = Player.getCurrentTime()
            let remaining = this.mostrarTiempo(comentarios, ctime, msgContainer)
            this.ordenarMensaje(msgContainer, remaining)
        }, 1000);
    },
    mostrarTiempo(comentarios, segundos, msgContainer){
        return comentarios.filter(com => {
            if(com.at > segundos){
                return true
            } else {
                this.muestraComentario(msgContainer, com)
                return false
            }
        })
    },
    formatoTiempo(at) {
        let fecha = new Date(null)
        fecha.setSeconds(at / 1000)
        return fecha.toISOString().substr(14, 5)
    }

}
export default Video
