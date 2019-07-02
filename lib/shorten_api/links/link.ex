defmodule ShortenApi.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :hash, :string
    field :uri, EctoURI

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:hash, :uri])
    |> validate_required([:hash, :uri])
    |> unique_constraint(:hash)
    |> unique_constraint(:uri)
  end
end
