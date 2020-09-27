defmodule ShortyWeb.PageController do
  use ShortyWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def find(conn, params = %{"slug" => slug} ) do
    redirect(conn, external: "http://google.com")
  end
end
