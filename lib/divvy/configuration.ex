defmodule Divvy.Configuration do
  use GenServer

  # Client

  def start_link do
    initial_state = %{ aliases: {}, primary: 1 }
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  def register_alias(station_id, station_name) do
    GenServer.cast(__MODULE__, {:register_alias, station_id, station_name})
  end

  def set_primary(station_id) do
    GenServer.cast(__MODULE__, {:set_primary, station_id})
  end

  def get_primary do
    GenServer.call(__MODULE__, {:get_primary})
  end

  # Server

  def handle_cast({:register, station_id, station_name}, state = %{aliases: aliases}) do
    {:noreply, %{state | aliases: %{aliases | station_id => station_name}}}
  end

  def handle_cast({:set_primary, station_id}, state) do
    {:noreply, %{state | primary: station_id}}
  end

  def handle_call({:get_primary}, _from, state = %{primary: primary_id}) do
    {:reply, {:ok, primary_id}, state}
  end
end
