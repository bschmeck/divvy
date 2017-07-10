printer_maker = fn(name) ->
  fn(%{"availableBikes" => bikes, "availableDocks" => docks, "totalDocks" => capacity}) ->
    reds = capacity - bikes - docks
    IO.puts "#{name} #{bikes} . #{docks} . #{reds}"
  end
end

{:ok, station_id} = GenServer.call({Divvy.Configuration, :"divvy@osprey"}, {:get_primary})
{:ok, station_name} = GenServer.call({Divvy.Configuration, :"divvy@osprey"}, {:alias_for, station_id})
printer = printer_maker.(station_name)

case GenServer.call({Divvy.StationData, :"divvy@osprey"}, {:get, station_id}) do
  {:found, station} -> printer.(station)
  {:missing, _} -> IO.puts "No Data"
end
