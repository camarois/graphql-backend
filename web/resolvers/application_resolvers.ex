defmodule Backend.App.Web.Resolvers.ApplicationResolvers do
    @moduledoc """
    Provides application query resolvers.
    """
    alias Backend.App.Configuration

    def applications(_, _) do
      {:ok, Configuration.list_applications()}
    end

    def application(%{id: id}, _info) do
      case Configuration.get_application!(id) do
        nil -> {:error, "Application #{id} not found"}
        application -> {:ok, application}
      end
    end

    def update(%{id: id, application: application_params}, info) do
      case application(%{id: id}, info) do
        {:ok, application} -> application |> Configuration.update_application(application_params)
        {:error, _} -> {:error, "Application #{id} not found"}
      end
    end

    def create(%{id: id, application: application_params}, info) do
      case application(%{id: id}, info) do
        {:error, _} -> Configuration.create_application(application_params)
        {:ok, _application} -> {:error, "This application_id #{application_params.application_id} already exists"}
      end
    end

    def delete(%{id: id}, info) do
      case application(%{id: id}, info) do
        {:ok, application} ->
          Configuration.delete_application(application)
          {:ok, %{done: true, application_id: application.application_id}}
        {:error, _} -> {:error, %{done: false, application_id: nil}}
      end
    end
  end
