defmodule Backend.App.SubscriptionCase do
  @moduledoc """
  This module defines the test case to be used by subscription tests
  """

  use ExUnit.CaseTemplate

  alias Absinthe.Phoenix.SubscriptionTest
  alias Backend.App.UserSocket

  using do
    quote do
      use Backend.App.ChannelCase

      use Absinthe.Phoenix.SubscriptionTest,
        schema: Backend.App.Web.Schema

      setup do
        {:ok, socket} = Phoenix.ChannelTest.connect(UserSocket, %{})
        {:ok, socket} = SubscriptionTest.join_absinthe(socket)
        {:ok, socket: socket}
      end
    end
  end
end
