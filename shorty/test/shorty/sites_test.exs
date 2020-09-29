defmodule Shorty.SitesTest do
  use Shorty.DataCase

  alias Shorty.Sites

  describe "links" do
    alias Shorty.Sites.Link

    @valid_attrs %{slug: "ABCSDF", url: "some url"}
  # @update_attrs %{slug: "some updated slug", url: "some updated url"}
    @invalid_attrs %{slug: nil, url: nil}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sites.create_link()

      link
    end


    test "get_link/1 returns the link with given id" do
      link = link_fixture()
      assert Sites.get_link(link.slug) == link
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = Sites.create_link(@valid_attrs)
      assert link.slug == "ABCSDF"
      assert link.url == "some url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sites.create_link(@invalid_attrs)
    end

    test "slugs must be unique" do
     {:ok, _} = Sites.create_link(@valid_attrs)
     assert {:error, _} = Sites.create_link(@valid_attrs)          
    end

  end
end
