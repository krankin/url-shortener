defmodule Shorty.Repo.Migrations.AddIndexOnSlugs do
  use Ecto.Migration

  def up do
    create index("links", [:slug, :url])
  end

  def down do
    drop index("links", [:slug, :url])
  end
end
