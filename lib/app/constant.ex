defmodule Backend.App.Constant do
  @moduledoc """
  Provides constants.
  """
  import Backend.Constants

  # field schema constants
  const(
    :field_url,
    "https://"
  )

  const(:field_url_fields, "&fields[]=")

  const(:all_fields, [
    ""
  ])

  # car schema constants
  const(
    :car_url,
    "https:"
  )
end
