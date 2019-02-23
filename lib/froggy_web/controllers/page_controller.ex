defmodule FroggyWeb.PageController do
  use FroggyWeb, :controller
  alias Froggy.School

  def index(conn, _params) do
    render(conn, "index.html", dire: School.dire_assignments())
  end
end
