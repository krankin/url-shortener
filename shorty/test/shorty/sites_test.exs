defmodule Shorty.SitesTest do
  use Shorty.DataCase

  alias Shorty.Sites

  describe "links" do
    alias Shorty.Sites.Link

    @valid_attrs %{slug: "some slug", url: "some url"}
    @update_attrs %{slug: "some updated slug", url: "some updated url"}
    @invalid_attrs %{slug: nil, url: nil}

    def link_fixture(attrs \\ %{}) do
      {:ok, link} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Sites.create_link()

      link
    end

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Sites.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Sites.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      assert {:ok, %Link{} = link} = Sites.create_link(@valid_attrs)
      assert link.slug == "some slug"
      assert link.url == "some url"
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Sites.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      assert {:ok, %Link{} = link} = Sites.update_link(link, @update_attrs)
      assert link.slug == "some updated slug"
      assert link.url == "some updated url"
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Sites.update_link(link, @invalid_attrs)
      assert link == Sites.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Sites.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Sites.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Sites.change_link(link)
    end
  end
end
