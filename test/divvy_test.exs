defmodule DivvyTest do
  use ExUnit.Case
  doctest Divvy

  test "storing and retrieving the primary station id" do
    station_id = 111
    Divvy.Configuration.set_primary(station_id)
    assert Divvy.Configuration.get_primary == {:ok, station_id}
  end

  test "storing and retrieving a station alias" do
    station_id = 111
    station_alias = "Test Station"
    Divvy.Configuration.register_alias(station_id, station_alias)
    #assert Divvy.Configuration.alias_for(station_id) == {:ok, station_alias}
  end
end
