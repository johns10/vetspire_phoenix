defmodule Vetspire.Dogs.Dog do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "dogs" do
    field :name, :string
    timestamps()
  end

  @doc false
  def changeset(dogs, attrs) do
    dogs
    |> cast(attrs, [])
    |> validate_required([])
  end
end
