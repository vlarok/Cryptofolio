defmodule Cryptofolio.CoinController do
  use Cryptofolio.Web, :controller

  alias Cryptofolio.Coin

  def index(conn, _params) do
    coins = Repo.all(Coin)
    Enum.each(coins, fn (coin) -> 
      case HTTPoison.get("https://api.coinmarketcap.com/v1/ticker/#{coin.name}/?convert=EUR") do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          price = body
                    |> Poison.decode!
                    #|> Enum.map(fn (x) -> x["price_eur"] end)
          # [x|_] = price

          #  = x
          [x] = price
         # %{price_eur: price_eur} = x
         calculated = String.to_float(x["price_eur"]) * coin.total

         new = Map.put(coin, :value, calculated)
         IO.inspect(new)

         changeset = Coin.changeset(coin, %{value: round(calculated)})
         Repo.update(changeset)


        {:ok, %HTTPoison.Response{status_code: 404}} ->
          IO.puts "Not found :("
        {:error, %HTTPoison.Error{reason: reason}} ->
          IO.inspect reason
      end
      # {:ok, response} = HTTPoison.get "https://api.coinmarketcap.com/v1/ticker/#{coin.name}/?convert=EUR"
      # IO.inspect(response) 
    
    end)
   
   
    
    
    revenue = Repo.one(from p in Coin, select: sum(p.value))
      |>IO.inspect

    render(conn, "index.html", coins: coins, revenue: revenue)
  end

  def new(conn, _params) do
    changeset = Coin.changeset(%Coin{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"coin" => coin_params}) do
    changeset = Coin.changeset(%Coin{}, coin_params)

    case Repo.insert(changeset) do
      {:ok, coin} ->
        conn
        |> put_flash(:info, "Coin created successfully.")
        |> redirect(to: coin_path(conn, :show, coin))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    coin = Repo.get!(Coin, id)
    render(conn, "show.html", coin: coin)
  end

  def edit(conn, %{"id" => id}) do
    coin = Repo.get!(Coin, id)
    changeset = Coin.changeset(coin)
    render(conn, "edit.html", coin: coin, changeset: changeset)
  end

  def update(conn, %{"id" => id, "coin" => coin_params}) do
    coin = Repo.get!(Coin, id)
    changeset = Coin.changeset(coin, coin_params)

    case Repo.update(changeset) do
      {:ok, coin} ->
        conn
        |> put_flash(:info, "Coin updated successfully.")
        |> redirect(to: coin_path(conn, :show, coin))
      {:error, changeset} ->
        render(conn, "edit.html", coin: coin, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    coin = Repo.get!(Coin, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(coin)

    conn
    |> put_flash(:info, "Coin deleted successfully.")
    |> redirect(to: coin_path(conn, :index))
  end
end
