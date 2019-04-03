defmodule VideoramaWeb.PageControllerTest do
  use VideoramaWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Videorama"
  end
end
