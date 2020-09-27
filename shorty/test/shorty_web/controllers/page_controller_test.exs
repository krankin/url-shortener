defmodule ShortyWeb.PageControllerTest do
  use ShortyWeb.ConnCase

  alias Shorty.Link

  def generate_slug do
    {:ok, slug} = Link.create_slug("http://foobar.com")
    slug
  end

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end

    test "GET /slug", %{conn: conn} do
    slug = generate_slug()
    conn = get(conn, "/#{slug}")
    assert html_response(conn, 302) =~ "redirected"
  end
end
