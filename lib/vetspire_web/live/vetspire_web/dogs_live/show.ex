defmodule VetspireWeb.DogsLive.Show do
  use VetspireWeb, :live_view

  alias Vetspire.VetspireWeb

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:dogs, VetspireWeb.get_dogs!(id))}
  end

  defp page_title(:show), do: "Show Dogs"
  defp page_title(:edit), do: "Edit Dogs"
end
