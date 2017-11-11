defmodule CapturecampusWeb.BuildingController do
  use CapturecampusWeb, :controller

  alias Capturecampus.Campus
  alias Capturecampus.Campus.Building

  def index(conn, _params) do
    buildings = Campus.list_buildings()
    render(conn, "index.html", buildings: buildings)
  end

  def new(conn, _params) do
    changeset = Campus.change_building(%Building{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"building" => building_params}) do
    case Campus.create_building(building_params) do
      {:ok, building} ->
        conn
        |> put_flash(:info, "Building created successfully.")
        |> redirect(to: building_path(conn, :show, building))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    building = Campus.get_building!(id)
    render(conn, "show.html", building: building)
  end

  def edit(conn, %{"id" => id}) do
    building = Campus.get_building!(id)
    changeset = Campus.change_building(building)
    render(conn, "edit.html", building: building, changeset: changeset)
  end

  def update(conn, %{"id" => id, "building" => building_params}) do
    building = Campus.get_building!(id)

    case Campus.update_building(building, building_params) do
      {:ok, building} ->
        conn
        |> put_flash(:info, "Building updated successfully.")
        |> redirect(to: building_path(conn, :show, building))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", building: building, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    building = Campus.get_building!(id)
    {:ok, _building} = Campus.delete_building(building)

    conn
    |> put_flash(:info, "Building deleted successfully.")
    |> redirect(to: building_path(conn, :index))
  end
end
