defmodule ShortenApi.Repo.Migrations.ConvertUrl do
  use Ecto.Migration

  def change do
    alter table(:links) do
      remove(:url)
      add(:uri, :map)
    end
  end
end
