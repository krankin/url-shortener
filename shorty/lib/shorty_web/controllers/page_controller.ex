defmodule ShortyWeb.PageController do
  use ShortyWeb, :controller
  alias Shorty.Sites

  def index(conn, _params) do
    conn
    |> assign(:newlink, nil)
    |> render("index.html", changeset:  Shorty.Sites.Link.changeset(%Shorty.Sites.Link{}, %{}))
  end

  def find(conn, %{"slug" => slug} ) do
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

  def create(conn, %{"link" => link_changeset} ) do 

    if Helpers.UrlValidator.is_valid?(Map.get(link_changeset, "url")) do   

      slug = Helpers.SlugGenerator.generate(Application.get_env(:shorty, :slug_length, 7));            
      link_changeset = Map.put(link_changeset, "slug", slug) 
      
      case Sites.create_link(link_changeset) do
        {:ok, link} -> 
          [referer] = get_req_header(conn, "referer")
        
          conn
          |> put_flash(:info, "Congratulations on your new link:")
          |> assign(:newlink, referer <> link.slug)
          |> render("index.html", changeset: Shorty.Sites.Link.changeset(%Shorty.Sites.Link{}, %{}))
        {:error, changeset} -> 
          conn
          |> put_flash(:error, "Error creating link:") 
          |> assign(:newlink, nil)       
          |> render("index.html", changeset: changeset)
      end
    else
      conn
      |> put_flash(:error, "That URL is not valid, try again")
      |> assign(:newlink, nil)
      |> render("index.html", changeset: Shorty.Sites.Link.changeset(%Shorty.Sites.Link{}, link_changeset))
    end
  end
end
