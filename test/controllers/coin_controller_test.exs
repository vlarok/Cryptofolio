defmodule Cryptofolio.CoinControllerTest do
  use Cryptofolio.ConnCase

  alias Cryptofolio.Coin
  @valid_attrs %{name: "some name", total: 42, value: 42}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, coin_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing coins"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, coin_path(conn, :new)
    assert html_response(conn, 200) =~ "New coin"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, coin_path(conn, :create), coin: @valid_attrs
    coin = Repo.get_by!(Coin, @valid_attrs)
    assert redirected_to(conn) == coin_path(conn, :show, coin.id)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, coin_path(conn, :create), coin: @invalid_attrs
    assert html_response(conn, 200) =~ "New coin"
  end

  test "shows chosen resource", %{conn: conn} do
    coin = Repo.insert! %Coin{}
    conn = get conn, coin_path(conn, :show, coin)
    assert html_response(conn, 200) =~ "Show coin"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, coin_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    coin = Repo.insert! %Coin{}
    conn = get conn, coin_path(conn, :edit, coin)
    assert html_response(conn, 200) =~ "Edit coin"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    coin = Repo.insert! %Coin{}
    conn = put conn, coin_path(conn, :update, coin), coin: @valid_attrs
    assert redirected_to(conn) == coin_path(conn, :show, coin)
    assert Repo.get_by(Coin, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    coin = Repo.insert! %Coin{}
    conn = put conn, coin_path(conn, :update, coin), coin: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit coin"
  end

  test "deletes chosen resource", %{conn: conn} do
    coin = Repo.insert! %Coin{}
    conn = delete conn, coin_path(conn, :delete, coin)
    assert redirected_to(conn) == coin_path(conn, :index)
    refute Repo.get(Coin, coin.id)
  end
end
