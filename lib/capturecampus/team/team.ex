defmodule Capturecampus.Team do
  @moduledoc """
  The Team context.
  """

  import Ecto.Query, warn: false
  alias Capturecampus.Repo

  alias Capturecampus.Team.Affiliation

  @doc """
  Returns the list of affiliations.

  ## Examples

      iex> list_affiliations()
      [%Affiliation{}, ...]

  """
  def list_affiliations do
    Repo.all(Affiliation)
  end

  @doc """
  Gets a single affiliation.

  Raises `Ecto.NoResultsError` if the Affiliation does not exist.

  ## Examples

      iex> get_affiliation!(123)
      %Affiliation{}

      iex> get_affiliation!(456)
      ** (Ecto.NoResultsError)

  """
  def get_affiliation!(id), do: Repo.get!(Affiliation, id)

  def get_by_color(color), do: Repo.get_by(Affiliation, color: color)

  @doc """
  Creates a affiliation.

  ## Examples

      iex> create_affiliation(%{field: value})
      {:ok, %Affiliation{}}

      iex> create_affiliation(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_affiliation(attrs \\ %{}) do
    %Affiliation{}
    |> Affiliation.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a affiliation.

  ## Examples

      iex> update_affiliation(affiliation, %{field: new_value})
      {:ok, %Affiliation{}}

      iex> update_affiliation(affiliation, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_affiliation(%Affiliation{} = affiliation, attrs) do
    affiliation
    |> Affiliation.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Affiliation.

  ## Examples

      iex> delete_affiliation(affiliation)
      {:ok, %Affiliation{}}

      iex> delete_affiliation(affiliation)
      {:error, %Ecto.Changeset{}}

  """
  def delete_affiliation(%Affiliation{} = affiliation) do
    Repo.delete(affiliation)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking affiliation changes.

  ## Examples

      iex> change_affiliation(affiliation)
      %Ecto.Changeset{source: %Affiliation{}}

  """
  def change_affiliation(%Affiliation{} = affiliation) do
    Affiliation.changeset(affiliation, %{})
  end
end
