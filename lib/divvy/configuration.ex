defmodule Divvy.Configuration do
  use GenServer

  # Client

  def start_link do
    initial_state = %{ aliases: %{}, primary: 1 }
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

  def alias_for(station_id) do
    GenServer.call(__MODULE__, {:alias_for, station_id})
  end

  # Server

  def handle_cast({:register_alias, station_id, station_name}, state = %{aliases: aliases}) do
    new_aliases = Map.put(aliases, station_id, station_name)
    {:noreply, %{state | aliases: new_aliases} }
  end

  def handle_cast({:set_primary, station_id}, state) do
    {:noreply, %{state | primary: station_id}}
  end

  def handle_call({:get_primary}, _from, state = %{primary: primary_id}) do
    {:reply, {:ok, primary_id}, state}
  end

  def handle_call({:alias_for, station_id}, _from, state = %{aliases: aliases}) do
    {:reply, {:ok, aliases[station_id]}, state}
  end
end
