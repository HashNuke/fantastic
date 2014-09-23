defmodule Fantastic.Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Riak

  def conf do
    [host: "localhost", bucket_type: "fantastic-analytics"]
  end

end
