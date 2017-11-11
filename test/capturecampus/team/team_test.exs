defmodule Capturecampus.TeamTest do
  use Capturecampus.DataCase

  alias Capturecampus.Team

  describe "affiliations" do
    alias Capturecampus.Team.Affiliation

    @valid_attrs %{color: "some color"}
    @update_attrs %{color: "some updated color"}
    @invalid_attrs %{color: nil}

    def affiliation_fixture(attrs \\ %{}) do
      {:ok, affiliation} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Team.create_affiliation()

      affiliation
    end

    test "list_affiliations/0 returns all affiliations" do
      affiliation = affiliation_fixture()
      assert Team.list_affiliations() == [affiliation]
    end

    test "get_affiliation!/1 returns the affiliation with given id" do
      affiliation = affiliation_fixture()
      assert Team.get_affiliation!(affiliation.id) == affiliation
    end

    test "create_affiliation/1 with valid data creates a affiliation" do
      assert {:ok, %Affiliation{} = affiliation} = Team.create_affiliation(@valid_attrs)
      assert affiliation.color == "some color"
    end

    test "create_affiliation/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Team.create_affiliation(@invalid_attrs)
    end

    test "update_affiliation/2 with valid data updates the affiliation" do
      affiliation = affiliation_fixture()
      assert {:ok, affiliation} = Team.update_affiliation(affiliation, @update_attrs)
      assert %Affiliation{} = affiliation
      assert affiliation.color == "some updated color"
    end

    test "update_affiliation/2 with invalid data returns error changeset" do
      affiliation = affiliation_fixture()
      assert {:error, %Ecto.Changeset{}} = Team.update_affiliation(affiliation, @invalid_attrs)
      assert affiliation == Team.get_affiliation!(affiliation.id)
    end

    test "delete_affiliation/1 deletes the affiliation" do
      affiliation = affiliation_fixture()
      assert {:ok, %Affiliation{}} = Team.delete_affiliation(affiliation)
      assert_raise Ecto.NoResultsError, fn -> Team.get_affiliation!(affiliation.id) end
    end

    test "change_affiliation/1 returns a affiliation changeset" do
      affiliation = affiliation_fixture()
      assert %Ecto.Changeset{} = Team.change_affiliation(affiliation)
    end
  end
end
