defmodule VetspireWeb.VetspireWeb.DogsLiveTest do
  use VetspireWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Vetspire.Dogs

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  defp fixture(:dogs) do
    {:ok, dogs} = Dogs.create_dogs(@create_attrs)
    dogs
  end

  defp create_dogs(_) do
    dogs = fixture(:dogs)
    %{dogs: dogs}
  end

  describe "Index" do
    setup [:create_dogs]

    test "lists all dogs", %{conn: conn, dogs: dogs} do
      {:ok, _index_live, html} = live(conn, Routes.vetspire_web_dogs_index_path(conn, :index))

      assert html =~ "Listing Dogs"
    end

    test "saves new dogs", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.vetspire_web_dogs_index_path(conn, :index))

      assert index_live |> element("a", "New Dogs") |> render_click() =~
               "New Dogs"

      assert_patch(index_live, Routes.vetspire_web_dogs_index_path(conn, :new))

      assert index_live
             |> form("#dogs-form", dogs: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#dogs-form", dogs: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.vetspire_web_dogs_index_path(conn, :index))

      assert html =~ "Dogs created successfully"
    end

    test "updates dogs in listing", %{conn: conn, dogs: dogs} do
      {:ok, index_live, _html} = live(conn, Routes.vetspire_web_dogs_index_path(conn, :index))

      assert index_live |> element("#dogs-#{dogs.id} a", "Edit") |> render_click() =~
               "Edit Dogs"

      assert_patch(index_live, Routes.vetspire_web_dogs_index_path(conn, :edit, dogs))

      assert index_live
             |> form("#dogs-form", dogs: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#dogs-form", dogs: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.vetspire_web_dogs_index_path(conn, :index))

      assert html =~ "Dogs updated successfully"
    end

    test "deletes dogs in listing", %{conn: conn, dogs: dogs} do
      {:ok, index_live, _html} = live(conn, Routes.vetspire_web_dogs_index_path(conn, :index))

      assert index_live |> element("#dogs-#{dogs.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#dogs-#{dogs.id}")
    end
  end

  describe "Show" do
    setup [:create_dogs]

    test "displays dogs", %{conn: conn, dogs: dogs} do
      {:ok, _show_live, html} = live(conn, Routes.vetspire_web_dogs_show_path(conn, :show, dogs))

      assert html =~ "Show Dogs"
    end

    test "updates dogs within modal", %{conn: conn, dogs: dogs} do
      {:ok, show_live, _html} = live(conn, Routes.vetspire_web_dogs_show_path(conn, :show, dogs))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Dogs"

      assert_patch(show_live, Routes.vetspire_web_dogs_show_path(conn, :edit, dogs))

      assert show_live
             |> form("#dogs-form", dogs: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#dogs-form", dogs: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.vetspire_web_dogs_show_path(conn, :show, dogs))

      assert html =~ "Dogs updated successfully"
    end
  end
end
