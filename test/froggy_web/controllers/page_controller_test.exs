defmodule FroggyWeb.PageControllerTest do
  use FroggyWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Assignments"
  end
end
