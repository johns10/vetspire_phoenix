defmodule VetspireWeb.DogsLive.Index do
  use VetspireWeb, :live_view

  alias Vetspire.Dogs
  alias Vetspire.Dogs.Dog

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :dogs_collection, list_dogs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Dogs")
    |> assign(:dogs, Dogs.get_dogs!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Dogs")
    |> assign(:dogs, %Dog{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Dogs")
    |> assign(:dogs, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    dogs = Dogs.get_dogs!(id)
    {:ok, _} = Dogs.delete_dogs(dogs)

    {:noreply, assign(socket, :dogs_collection, list_dogs())}
  end

  defp list_dogs do
    Dogs.list_dogs()
  end
end
