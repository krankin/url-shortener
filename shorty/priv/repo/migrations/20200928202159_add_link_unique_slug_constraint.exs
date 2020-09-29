defmodule Shorty.Repo.Migrations.AddLinkUniqueSlugConstraint do
  use Ecto.Migration

  def up do
    create unique_index(:links, [:slug] )
  end

  def down do
    drop unique_index(:links, [:slug] )
  end
end
