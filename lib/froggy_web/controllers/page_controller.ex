defmodule FroggyWeb.PageController do
  use FroggyWeb, :controller
  alias Froggy.School

  def index(conn, _params) do
    render(conn, "index.html", dire: School.dire_assignments(), token: get_csrf_token())
  end

  def complete(conn, params) do
    School.complete(params["id"])
    text(conn, "completed")
  end
end
