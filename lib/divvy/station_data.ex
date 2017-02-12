defmodule Divvy.StationData do
  use GenServer

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
