defmodule ShortyWeb.PageController do
  use ShortyWeb, :controller
  alias Shorty.Sites

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def find(conn, params = %{"slug" => slug} ) do
    site = Sites.get_link!(slug)    
    redirect(conn, external: site.url)
  end
end
