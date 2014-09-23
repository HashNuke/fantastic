defmodule Fantastic.Event do
  use Ecto.Model

  schema "events" do
    field :name
    field :data_map,   :virtual
    field :created_at, :datetime
  end

end
