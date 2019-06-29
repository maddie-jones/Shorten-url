defmodule ShortenApi.Links.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :hash, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:hash, :url])
    |> generate_hash(attrs)
    |> validate_required([:hash, :url])
    |> unique_constraint(:hash)
    |> unique_constraint(:url)
  end

  defp generate_hash(%__MODULE__{} = link, %{"hash" => ""}), do: generate_hash(link, %{hash: nil})

  defp generate_hash(%__MODULE__{id: id} = link, %{"hash" => nil}) do
    hashids = Hashids.new(salt: "this is my salt")
    new_id = Hashids.encode(hashids, [id])
    Map.put(link, :hash, new_id)
  end

  defp generate_hash(%__MODULE__{} = link, %{"hash" => hash}), do: link
end
