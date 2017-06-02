defmodule Divvy do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Divvy.StationData, []),
      worker(Divvy.Fetcher, [])
    ]

    opts = [strategy: :one_for_one, name: Divvy.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
