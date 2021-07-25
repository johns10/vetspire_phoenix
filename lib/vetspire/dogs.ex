defmodule Vetspire.Dogs do
  @moduledoc """
  The VetspireWeb context.
  """

  import Ecto.Query, warn: false
  alias Vetspire.Repo

  alias Vetspire.Dogs.Dog
  alias Vetspire.Generator

  @doc """
  Returns the list of dogs.

  ## Examples

      iex> list_dogs()
      [%Dogs{}, ...]

  """
  def list_dogs do
    File.cwd!
    |> Generator.images_dir()
    |> File.cd()

    File.ls!
    |> Enum.map(fn(file_name) ->
      name =
        file_name
        |> String.slice(0..-5)

      %Dog{name: name}
    end)

  end

  @doc """
  Gets a single dogs.

  Raises `Ecto.NoResultsError` if the Dogs does not exist.

  ## Examples

      iex> get_dogs!(123)
      %Dogs{}

      iex> get_dogs!(456)
      ** (Ecto.NoResultsError)

  """
  def get_dogs!(id), do: Repo.get!(Dog, id)

  @doc """
  Creates a dogs.

  ## Examples

      iex> create_dogs(%{field: value})
      {:ok, %Dogs{}}

      iex> create_dogs(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_dogs(attrs \\ %{}) do
    %Dog{}
    |> Dog.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a dogs.

  ## Examples

      iex> update_dogs(dogs, %{field: new_value})
      {:ok, %Dogs{}}

      iex> update_dogs(dogs, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_dogs(%Dog{} = dogs, attrs) do
    dogs
    |> Dog.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a dogs.

  ## Examples

      iex> delete_dogs(dogs)
      {:ok, %Dogs{}}

      iex> delete_dogs(dogs)
      {:error, %Ecto.Changeset{}}

  """
  def delete_dogs(%Dog{} = dogs) do
    Repo.delete(dogs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking dogs changes.

  ## Examples

      iex> change_dogs(dogs)
      %Ecto.Changeset{data: %Dogs{}}

  """
  def change_dogs(%Dog{} = dogs, attrs \\ %{}) do
    Dog.changeset(dogs, attrs)
  end
end
