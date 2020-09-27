defmodule ShortyWeb.PageController do
  use ShortyWeb, :controller
  alias Shorty.Sites

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def find(conn, params = %{"slug" => slug} ) do
     case Sites.get_link(slug)   do
       nil -> 
        conn
        |> put_status(:not_found)
        |> put_view(ShortyWeb.ErrorView)
        |> render(:"404")
       site ->
        redirect(conn, external: site.url)
     end
  end

end
