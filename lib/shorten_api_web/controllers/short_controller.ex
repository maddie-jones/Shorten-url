defmodule ShortenApiWeb.ShortController do
  use ShortenApiWeb, :controller

  alias ShortenApi.Links

  action_fallback ShortenApiWeb.FallbackController

  def reroute(conn, _params) do
    conn
    |> redirect(external: "http://example.com")
  end
end
