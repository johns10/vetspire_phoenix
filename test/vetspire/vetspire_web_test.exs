defmodule Vetspire.DogsTest do
  use Vetspire.DataCase

  alias Vetspire.Dogs

  describe "dogs" do
    alias Vetspire.Dogs.Dog

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def dogs_fixture(attrs \\ %{}) do
      {:ok, dogs} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Dogs.create_dogs()

      dogs
    end

    test "list_dogs/0 returns all dogs" do
      dogs = dogs_fixture()
      [dog | _] = Dogs.list_dogs()
      assert dog.name == "Abrador Retriever"
    end
"""
    test "get_dogs!/1 returns the dogs with given id" do
      dogs = dogs_fixture()
      assert Dogs.get_dogs!(dogs.id) == dogs
    end

    test "create_dogs/1 with valid data creates a dogs" do
      assert {:ok, %Dog{} = dogs} = Dogs.create_dogs(@valid_attrs)
    end

    test "create_dogs/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dogs.create_dogs(@invalid_attrs)
    end

    test "update_dogs/2 with valid data updates the dogs" do
      dogs = dogs_fixture()
      assert {:ok, %Dog{} = dogs} = Dogs.update_dogs(dogs, @update_attrs)
    end

    test "update_dogs/2 with invalid data returns error changeset" do
      dogs = dogs_fixture()
      assert {:error, %Ecto.Changeset{}} = Dogs.update_dogs(dogs, @invalid_attrs)
      assert dogs == Dogs.get_dogs!(dogs.id)
    end

    test "delete_dogs/1 deletes the dogs" do
      dogs = dogs_fixture()
      assert {:ok, %Dog{}} = Dogs.delete_dogs(dogs)
      assert_raise Ecto.NoResultsError, fn -> Dogs.get_dogs!(dogs.id) end
    end

    test "change_dogs/1 returns a dogs changeset" do
      dogs = dogs_fixture()
      assert %Ecto.Changeset{} = Dogs.change_dogs(dogs)
    end
    """
  end
end
