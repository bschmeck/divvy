defmodule Divvy.Fetcher do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(state) do
    Process.send_after(self(), :feed, 60 * 1000)
    {:ok, state}
  end

  def handle_info(:feed, state) do
    feed |> Divvy.StationData.update
    Process.send_after(self(), :feed, 60 * 1000)
    {:noreply, state}
  end

  def feed do
    %HTTPoison.Response{body: body, status_code: 200} = HTTPoison.get! "https://feeds.divvybikes.com/stations/stations.json"
    json = Poison.Parser.parse! body
    json["stationBeanList"]
  end
end
