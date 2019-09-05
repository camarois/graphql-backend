defmodule Backend.App.Configuration do
  @moduledoc """
  The Configuration context.
  """

  import Ecto.Query, warn: false
  alias Backend.App.Repo

  alias Backend.App.Configuration.Settings

  @doc """
  Returns the list of settings.

  ## Examples

      iex> list_settings()
      [%settings{}, ...]

  """
  def list_settings do
    Repo.all(Settings)
  end

  @doc """
  Gets a single settings.

  Raises `Ecto.NoResultsError` if the settings does not exist.

  ## Examples

      iex> get_settings!(123)
      %settings{}

      iex> get_settings!(456)
      ** (Ecto.NoResultsError)

  """
  def get_setting!(id), do: Repo.get!(Settings, id)
  def get_setting_email!(email), do: Repo.get_by(Settings, email: email)

  @doc """
  Creates a settings.

  ## Examples

      iex> create_settings(%{field: value})
      {:ok, %settings{}}

      iex> create_settings(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_setting(attrs \\ %{}) do
    %Settings{}
    |> Settings.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a settings.

  ## Examples

      iex> update_settings(settings, %{field: new_value})
      {:ok, %settings{}}

      iex> update_settings(settings, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_setting(%Settings{} = settings, attrs) do
    settings
    |> Settings.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a settings.

  ## Examples

      iex> delete_settings(settings)
      {:ok, %settings{}}

      iex> delete_settings(settings)
      {:error, %Ecto.Changeset{}}

  """
  def delete_setting(%Settings{} = settings) do
    Repo.delete(settings)
  end

  alias Backend.App.Configuration.Applications

  def list_applications do
    apps = Repo.all(Applications)
    apps |> Repo.preload([:users])
  end

  def get_application!(id) do
    app = Repo.get(Applications, id)
    app |> Repo.preload([:users])
  end

  def create_application(attrs \\ %{}) do
    %Applications{}
    |> Applications.changeset(attrs)
    |> Repo.insert()
  end

  def update_application(%Applications{} = application, attrs) do
    application
    |> Applications.changeset(attrs)
    |> Repo.update()
  end

  def delete_application(%Applications{} = application) do
    Repo.delete(application)
  end
end
