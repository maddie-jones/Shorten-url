defmodule ShortenApiWeb.ShortControllerTest do
  use ShortenApiWeb.ConnCase

  alias ShortenApi.Links
  alias ShortenApi.Links.Link

  @create_attrs %{
    hash: "some hash",
    uri: "http://example.com/foo?thing=bar"
  }
  @update_attrs %{
    hash: "some updated hash",
    uri: "some updated uri"
  }
  @invalid_attrs %{hash: nil, uri: nil}

  def fixture(:link) do
    {:ok, link} = Links.create_link(@create_attrs)
    link
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "route redirected to other link", %{conn: conn} do
    conn = get(conn, Routes.short_path(conn, :reroute))

    assert 302 = conn.status
    assert ["http://example.com"] = Plug.Conn.get_resp_header(conn, "location")
  end
end
