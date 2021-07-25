defmodule VetspireWeb.VetspireWeb.DogsLive.FormComponent do
  use VetspireWeb, :live_component

  alias Vetspire.VetspireWeb

  @impl true
  def update(%{dogs: dogs} = assigns, socket) do
    changeset = VetspireWeb.change_dogs(dogs)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"dogs" => dogs_params}, socket) do
    changeset =
      socket.assigns.dogs
      |> VetspireWeb.change_dogs(dogs_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"dogs" => dogs_params}, socket) do
    save_dogs(socket, socket.assigns.action, dogs_params)
  end

  defp save_dogs(socket, :edit, dogs_params) do
    case VetspireWeb.update_dogs(socket.assigns.dogs, dogs_params) do
      {:ok, _dogs} ->
        {:noreply,
         socket
         |> put_flash(:info, "Dogs updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_dogs(socket, :new, dogs_params) do
    case VetspireWeb.create_dogs(dogs_params) do
      {:ok, _dogs} ->
        {:noreply,
         socket
         |> put_flash(:info, "Dogs created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
