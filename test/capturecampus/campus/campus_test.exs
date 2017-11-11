defmodule Capturecampus.CampusTest do
  use Capturecampus.DataCase

  alias Capturecampus.Campus

  describe "buildings" do
    alias Capturecampus.Campus.Building

    @valid_attrs %{abbrev: "some abbrev", address: "some address", image_path: "some image_path", lat: 120.5, long: 120.5, name: "some name"}
    @update_attrs %{abbrev: "some updated abbrev", address: "some updated address", image_path: "some updated image_path", lat: 456.7, long: 456.7, name: "some updated name"}
    @invalid_attrs %{abbrev: nil, address: nil, image_path: nil, lat: nil, long: nil, name: nil}

    def building_fixture(attrs \\ %{}) do
      {:ok, building} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Campus.create_building()

      building
    end

    test "list_buildings/0 returns all buildings" do
      building = building_fixture()
      assert Campus.list_buildings() == [building]
    end

    test "get_building!/1 returns the building with given id" do
      building = building_fixture()
      assert Campus.get_building!(building.id) == building
    end

    test "create_building/1 with valid data creates a building" do
      assert {:ok, %Building{} = building} = Campus.create_building(@valid_attrs)
      assert building.abbrev == "some abbrev"
      assert building.address == "some address"
      assert building.image_path == "some image_path"
      assert building.lat == 120.5
      assert building.long == 120.5
      assert building.name == "some name"
    end

    test "create_building/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Campus.create_building(@invalid_attrs)
    end

    test "update_building/2 with valid data updates the building" do
      building = building_fixture()
      assert {:ok, building} = Campus.update_building(building, @update_attrs)
      assert %Building{} = building
      assert building.abbrev == "some updated abbrev"
      assert building.address == "some updated address"
      assert building.image_path == "some updated image_path"
      assert building.lat == 456.7
      assert building.long == 456.7
      assert building.name == "some updated name"
    end

    test "update_building/2 with invalid data returns error changeset" do
      building = building_fixture()
      assert {:error, %Ecto.Changeset{}} = Campus.update_building(building, @invalid_attrs)
      assert building == Campus.get_building!(building.id)
    end

    test "delete_building/1 deletes the building" do
      building = building_fixture()
      assert {:ok, %Building{}} = Campus.delete_building(building)
      assert_raise Ecto.NoResultsError, fn -> Campus.get_building!(building.id) end
    end

    test "change_building/1 returns a building changeset" do
      building = building_fixture()
      assert %Ecto.Changeset{} = Campus.change_building(building)
    end
  end
end
