defmodule Backend.App.Accounts.UserTest do
  use ExUnit.Case
  alias Backend.App.Accounts
  alias Backend.App.Accounts.User
  alias Backend.App.Configuration
  alias Backend.App.Repo
  alias Ecto.Adapters.SQL.Sandbox

  setup do
    # Explicitly get a connection before each test
    # By default the test is wrapped in a transaction
    :ok = Sandbox.checkout(Repo)
    # The :shared mode allows a process to share
    # its connection with any other process automatically
    Sandbox.mode(Repo, {:shared, self()})

    {:ok, uuid = Ecto.UUID.generate()}
    {:ok, app_uuid = Ecto.UUID.generate()}

    Configuration.create_application(%{
      application_id: app_uuid,
      version: 0.1,
      default_language: "fr"
    })

    {:ok, application = Configuration.get_application!(app_uuid)}

    {:ok,
     _context = %{
       uuid: uuid,
       application: application,
       valid_attrs: %{
         application_id: application.application_id,
         address: "some address",
         age: 14,
         country: "some country",
         email: "some email",
         enable_wifi: true,
         gender: 0,
         name: "some name",
         phone: 336_066_666,
         user_id: uuid,
         wifi_pwd: "some wifi_pwd",
         wifi_ssid: "some wifi_ssid"
       },
       update_attrs: %{
         application_id: application.application_id,
         address: "updated address",
         age: 14,
         country: "updated country",
         email: "updated email",
         enable_wifi: true,
         gender: 0,
         name: "updated name",
         phone: 336_066_666,
         user_id: uuid,
         wifi_pwd: "updated wifi_pwd",
         wifi_ssid: "updated wifi_ssid"
       }
     }}
  end

  describe "user" do
    @invalid_attrs %{
      application: nil,
      address: nil,
      age: nil,
      country: nil,
      email: nil,
      enable_wifi: nil,
      gender: nil,
      name: nil,
      phone: nil,
      user_id: nil,
      wifi_pwd: nil,
      wifi_ssid: nil
    }

    def user_fixture(attrs) do
      {:ok, user} = Accounts.create_user(attrs)
      user
    end

    test "list_users/0 returns all users", context do
      user = user_fixture(context.valid_attrs)
      assert Enum.member?(Accounts.list_users(), user)
    end

    test "get_user!/1 returns the user with given id", context do
      user = user_fixture(context.valid_attrs)
      assert Accounts.get_user!(user.user_id) == user
    end

    test "get_user_email!/1 returns the user with given email", context do
      user = user_fixture(context.valid_attrs)
      assert Accounts.get_user_email!(user.email) == user
    end

    test "create_user/1 with valid data creates a user, than update and delete", context do
      assert {:ok, %User{} = user} = Accounts.create_user(context.valid_attrs)

      assert user.application_id == context.valid_attrs.application_id
      assert user.address == context.valid_attrs.address
      assert user.age == context.valid_attrs.age
      assert user.country == context.valid_attrs.country
      assert user.email == context.valid_attrs.email
      assert user.enable_wifi == context.valid_attrs.enable_wifi
      assert user.gender == context.valid_attrs.gender
      assert user.name == context.valid_attrs.name
      assert user.phone == context.valid_attrs.phone
      assert user.user_id == context.valid_attrs.user_id
      assert user.wifi_pwd == context.valid_attrs.wifi_pwd
      assert user.wifi_ssid == context.valid_attrs.wifi_ssid

      assert {:ok, %User{} = updated_user} = Accounts.update_user(user, context.update_attrs)

      assert updated_user.application_id == context.update_attrs.application_id
      assert updated_user.address == context.update_attrs.address
      assert updated_user.age == context.update_attrs.age
      assert updated_user.country == context.update_attrs.country
      assert updated_user.email == context.update_attrs.email
      assert updated_user.enable_wifi == context.update_attrs.enable_wifi
      assert updated_user.gender == context.update_attrs.gender
      assert updated_user.name == context.update_attrs.name
      assert updated_user.phone == context.update_attrs.phone
      assert updated_user.user_id == context.update_attrs.user_id
      assert updated_user.wifi_pwd == context.update_attrs.wifi_pwd
      assert updated_user.wifi_ssid == context.update_attrs.wifi_ssid

      assert {:ok, _} = Accounts.delete_user(updated_user)
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end
  end
end
