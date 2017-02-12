defmodule Divvy.StationData do
  use GenServer

  # Client

  def start_link do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def for_station(station_id) do
    GenServer.call(__MODULE__, {:for, station_id})
  end

  def update(data) do
    GenServer.cast(__MODULE__, {:update, data})
  end

  # Server

  def handle_call({:for, station_id}, _from, station_data) do
    reply = case Enum.find(station_data, &(&1["id"] == station_id)) do
              nil -> {:missing, %{}}
              station -> {:found, station}
            end

    {:reply, reply, station_data}
  end

  def handle_cast({:update, new_station_data}, _station_data) do
    {:noreply, new_station_data}
  end
end
