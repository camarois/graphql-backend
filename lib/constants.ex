defmodule Backend.Constants do
  @moduledoc """
  Provides method to create constants (in Backend.App.Constant file).
  """
  defmacro const(const_name, const_value) do
    quote do
      def unquote(const_name)(), do: unquote(const_value)
    end
  end
end
