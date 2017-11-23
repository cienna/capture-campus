defmodule CapturecampusWeb.AffiliationController do
  use CapturecampusWeb, :controller

  alias Capturecampus.Team
  alias Capturecampus.Team.Affiliation

  def index(conn, _params) do
    affiliations = Team.list_affiliations()
    render(conn, :index, affiliations: affiliations)
  end

  def new(conn, _params) do
    changeset = Team.change_affiliation(%Affiliation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"affiliation" => affiliation_params}) do
    case Team.create_affiliation(affiliation_params) do
      {:ok, affiliation} ->
        conn
        |> put_flash(:info, "Affiliation created successfully.")
        |> redirect(to: affiliation_path(conn, :show, affiliation))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    affiliation = Team.get_affiliation!(id)
    render(conn, "show.html", affiliation: affiliation)
  end

  def edit(conn, %{"id" => id}) do
    affiliation = Team.get_affiliation!(id)
    changeset = Team.change_affiliation(affiliation)
    render(conn, "edit.html", affiliation: affiliation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "affiliation" => affiliation_params}) do
    affiliation = Team.get_affiliation!(id)

    case Team.update_affiliation(affiliation, affiliation_params) do
      {:ok, affiliation} ->
        conn
        |> put_flash(:info, "Affiliation updated successfully.")
        |> redirect(to: affiliation_path(conn, :show, affiliation))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", affiliation: affiliation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    affiliation = Team.get_affiliation!(id)
    {:ok, _affiliation} = Team.delete_affiliation(affiliation)

    conn
    |> put_flash(:info, "Affiliation deleted successfully.")
    |> redirect(to: affiliation_path(conn, :index))
  end
end
