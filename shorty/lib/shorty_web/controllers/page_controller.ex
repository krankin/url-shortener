defmodule ShortyWeb.PageController do
  use ShortyWeb, :controller
  alias Shorty.Sites

  def index(conn, _params) do
    conn
    |> assign(:newlink, nil)
    |> render("index.html", changeset:  Shorty.Sites.Link.changeset(%Shorty.Sites.Link{}, %{}))
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

  def create(conn, params = %{"link" => link_changeset} ) do    
    slug = Helpers.SlugGenerator.generate(7);

    {:ok, link }= 
    Map.put(link_changeset, "slug", slug) |> Sites.create_link()

    conn
    |> put_flash(:info, "Congratulations on your new link:")
    |> assign(:newlink, ShortyWeb.Endpoint.url <> "/" <> link.slug)
    |> render("index.html", changeset: Shorty.Sites.Link.changeset(%Shorty.Sites.Link{}, %{}))
  end
end
