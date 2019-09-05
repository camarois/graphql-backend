defmodule Backend.App.Dashboard.DashboardTest do
  use ExUnit.Case
  alias Backend.App.Dashboard
  alias Backend.App.Repo
  alias Ecto.Adapters.SQL.Sandbox

  setup do
    # Explicitly get a connection before each test
    # By default the test is wrapped in a transaction
    :ok = Sandbox.checkout(Repo)
    # The :shared mode allows a process to share
    # its connection with any other process automatically
    Sandbox.mode(Repo, {:shared, self()})
  end

  describe "field" do
    alias Backend.App.Dashboard.Field

    @valid_attrs %{
      type: "some type",
      asset: "some asset",
      field_name: "some fieldname",
      field_value: 120.5,
      latitude: 120.5,
      longitude: 120.5,
      timestamp: "some timestamp"
    }
    @invalid_attrs %{
      type: nil,
      asset: nil,
      field_name: nil,
      field_value: nil,
      latitude: nil,
      longitude: nil,
      timestamp: nil
    }

    def field_fixture do
      {:ok, field} = Dashboard.create_field(@valid_attrs)
      field
    end

    test "list_fields/0 returns all fields" do
      field = field_fixture()
      assert Enum.member?(Dashboard.list_fields(), field)
    end

    test "get_field!/1 returns the field with given id" do
      field = field_fixture()
      assert Dashboard.get_field!(field.field_id) == field
    end

    test "create_field/1 with valid data creates a field" do
      assert {:ok, %Field{} = field} =
               Dashboard.create_field(@valid_attrs)

      assert field.type == "some type"
      assert field.asset == "some asset"
      assert field.field_name == "some fieldname"
      assert field.field_value == 120.5
      assert field.latitude == 120.5
      assert field.longitude == 120.5
      assert field.timestamp == "some timestamp"
    end

    test "create_field/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dashboard.create_field(@invalid_attrs)
    end
  end
end
