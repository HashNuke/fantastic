defmodule Fantastic.Server do
  def start_link do
    Plug.Adapters.Cowboy.http Fantastic.AppRouter, []
  end
end
