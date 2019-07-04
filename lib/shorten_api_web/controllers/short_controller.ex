defmodule ShortenApiWeb.ShortController do
  use ShortenApiWeb, :controller

  alias ShortenApi.Links

  action_fallback ShortenApiWeb.FallbackController

  def reroute(conn, %{"x" => x}) do
    conn
    |> redirect(external: "http://example.com")
  end
end
