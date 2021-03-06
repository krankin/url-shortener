defmodule Shorty.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :slug, :string
      add :url, :string

      timestamps()
    end

  end
end
