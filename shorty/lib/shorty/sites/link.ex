defmodule Shorty.Sites.Link do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "links" do
    field :slug, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:slug, :url])
    |> validate_required([:slug, :url])
    |> unique_constraint(:slug)
  end
end
