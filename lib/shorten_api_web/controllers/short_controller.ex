defmodule ShortenApiWeb.ShortController do
  use ShortenApiWeb, :controller

  alias ShortenApi.{Links, Links.Link}
  action_fallback ShortenApiWeb.FallbackController

  def reroute(conn, %{"hash" => hash}) do
    %Link{uri: retrieved_uri} = Links.get_link_by_hash!(hash)

    redirect(conn, external: retrieved_uri |> URI.to_string())
  end
end
