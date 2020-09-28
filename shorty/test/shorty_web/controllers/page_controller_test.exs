defmodule ShortyWeb.PageControllerTest do
  use ShortyWeb.ConnCase

  alias Shorty.Sites

  @valid_attrs %{slug: "ABCSDF", url: "https://www.google.com/search?q=url+shortener&oq=google+u&aqs=chrome.0.69i59j69i60l3j0j69i57.1069j0j7&sourceid=chrome&ie=UTF-8"}
  
  def generate_link(attrs \\ %{}) do
    {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sites.create_link()
      link
  end

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Enter a url you would like shortened:"
  end

  test "GET /slug", %{conn: conn} do
    link = generate_link()
    conn = get(conn, link.slug)
    assert html_response(conn, 302) =~ "redirected"
    assert redirected_to(conn, 302) =~ "https://www.google.com/search?q=url+shortener&oq=google+u&aqs=chrome.0.69i59j69i60l3j0j69i57.1069j0j7&sourceid=chrome&ie=UTF-8"
  end


  test "GET /slug returns 404 on unknown slug", %{conn: conn} do   
    conn = get(conn, "/Unknown")
    assert html_response(conn, 404) =~ "Oops!"    
  end

  test "POST /", %{conn: conn} do
    
    conn =
    conn 
    |> Plug.Conn.put_req_header("referer", "http://short.ly/")
    |> post("/",%{"link" =>  %{url: "https://news.ycombinator.com"}})

    assert html_response(conn, 200) =~ "Your shorty is:"   
  end

    test "POST / links to appropriate referer", %{conn: conn} do
    
    conn =
    conn 
    |> Plug.Conn.put_req_header("referer", "http://short.ly/")
    |> post("/",%{"link" =>  %{url: "https://news.ycombinator.com"}})

    assert html_response(conn, 200) =~ "http://short.ly/"   
  end

  test "POST / returns error if url isn't valid", %{conn: conn} do
    conn = post(conn, "/",%{"link" =>  %{url: "INV@L^DUR~~L"}})
    assert html_response(conn, 200) =~ "That URL is not valid, try again"
  end
end
