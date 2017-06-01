defmodule DivvyTest do
  use ExUnit.Case
  doctest Divvy

  test "storing and retrieving the primary station id" do
    station_id = 111
    Divvy.Configuration.set_primary(station_id)
    assert Divvy.Configuration.get_primary == {:ok, station_id}
  end
end
