defmodule Divvy do
  def feed do
    %HTTPoison.Response{body: body, status_code: 200} = HTTPoison.get! "https://feeds.divvybikes.com/stations/stations.json"
    Poison.Parser.parse! body
  end
end
