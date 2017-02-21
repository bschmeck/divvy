[station_name, station_id] = System.argv
{station_id, _} = Integer.parse(station_id)

printer_maker = fn(name) ->
  fn(%{"availableBikes" => bikes, "availableDocks" => docks, "totalDocks" => capacity}) ->
    reds = capacity - bikes - docks
    IO.puts "#{name} #{bikes} . #{docks} . #{reds}"
  end
end

printer = printer_maker.(station_name)

case GenServer.call({Divvy.StationData, :"foo@osprey"}, {:get, station_id}) do
  {:found, station} -> printer.(station)
  {:missing, _} -> IO.puts "No Data"
end
