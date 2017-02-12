defmodule Divvy do
  use Application

  def start(_type, _args) do
    Divvy.Supervisor.start_link
  end
end
