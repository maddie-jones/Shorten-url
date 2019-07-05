defmodule ShortenApiWeb.ShortControllerTest do
  use ShortenApiWeb.ConnCase

  alias ShortenApi.Links

  @create_attrs %{
    hash: "some hash",
    uri: "http://example.com/foo?thing=bar"
  }

  def fixture(:link) do
    {:ok, link} = Links.create_link(@create_attrs)
    link
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "route redirected to other link", %{conn: conn} do
    %_{uri: created_uri} = fixture(:link)
    created_uri = URI.to_string(created_uri)

    conn = get(conn, Routes.short_path(conn, :reroute, "some hash"))

    assert 302 = conn.status
    assert [^created_uri] = Plug.Conn.get_resp_header(conn, "location")
  end
end
