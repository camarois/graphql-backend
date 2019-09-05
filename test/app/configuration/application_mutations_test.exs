defmodule Backend.App.Configuration.ApplicationMutationsTest do
  use Backend.App.ConnCase

  setup do
    {:ok, app1_uuid = Ecto.UUID.generate()}
    {:ok, app2_uuid = Ecto.UUID.generate()}

    {:ok,
     _context = %{
       application: %{
         application_id: app1_uuid,
         version: 0.1,
         default_language: "fr"
       },
       update_application: %{
         application_id: app2_uuid,
         version: 0.2,
         default_language: "us"
       },
       invalid_application: %{
         application_id: nil,
         version: nil,
         default_language: nil
       }
     }}
  end

  describe "application mutations" do
    @create """
     mutation CreateApplication($id: ID!, $application: UpdateApplicationParams){
        createApplication(id: $id, application: $application){
          applicationId
          version
          defaultLanguage
       }
     }
    """

    @update """
      mutation UpdateApplication($id: ID!, $application: UpdateApplicationParams) {
        updateApplication(id: $id, application: $application) {
              applicationId
              version
              defaultLanguage
          }
      }
    """

    @delete """
      mutation DeleteApplication($id: ID!) {
        deleteApplication(id: $id) {
              done
              application_id
          }
      }
    """

    test "create a valid application", context do
      variables = %{id: context.application.application_id, application: context.application}
      delete_variables = %{id: context.application.application_id}

      res =
        context.conn
        |> post("/graphiql", query: @create, variables: variables)
        |> json_response(200)
        |> Map.get("data")

      assert res["createApplication"]["applicationId"] == context.application.application_id
      assert res["createApplication"]["version"] == context.application.version
      assert res["createApplication"]["defaultLanguage"] == context.application.default_language

      res =
        context.conn
        |> post("/graphiql", query: @delete, variables: delete_variables)
        |> json_response(200)
        |> Map.get("data")

      assert res["deleteApplication"]["done"] == true
      assert res["deleteApplication"]["application_id"] == context.application.application_id
    end

    test "create an application with an id that already exists", context do
      app1_variables = %{id: context.application.application_id, application: context.application}

      app2_variables = %{
        id: context.application.application_id,
        application: context.update_application
      }

      context.conn
      |> post("/graphiql", query: @create, variables: app1_variables)
      |> json_response(200)

      app2_res =
        context.conn
        |> post("/graphiql", query: @create, variables: app2_variables)
        |> json_response(200)

      assert Enum.at(app2_res["errors"], 0)["message"] ==
               "This application_id #{context.update_application.application_id} already exists"
    end

    test "create an invalid application", context do
      variables = %{
        id: context.invalid_application.application_id,
        application: context.invalid_application
      }

      res =
        context.conn
        |> post("/api", query: @create, variables: variables)
        |> json_response(200)
        |> Map.get("data")

      assert res["createApplication"] == nil
    end

    test "update an application", context do
      create_variables = %{
        id: context.application.application_id,
        application: context.application
      }

      update_variables = %{
        id: context.application.application_id,
        application: context.update_application
      }

      context.conn
      |> post("/graphiql", query: @create, variables: create_variables)
      |> json_response(200)

      update_res =
        context.conn
        |> post("/graphiql", query: @update, variables: update_variables)
        |> json_response(200)
        |> Map.get("data")

      assert update_res["updateApplication"]["applicationId"] ==
               context.update_application.application_id

      assert update_res["updateApplication"]["version"] == context.update_application.version

      assert update_res["updateApplication"]["defaultLanguage"] ==
               context.update_application.default_language
    end

    test "update an invalid user", context do
      create_variables = %{
        id: context.application.application_id,
        application: context.application
      }

      update_variables = %{
        id: context.update_application.application_id,
        application: context.update_application
      }

      context.conn
      |> post("/graphiql", query: @create, variables: create_variables)
      |> json_response(200)

      update_res =
        context.conn
        |> post("/graphiql", query: @update, variables: update_variables)
        |> json_response(200)

      assert Enum.at(update_res["errors"], 0)["message"] ==
               "Application #{context.update_application.application_id} not found"
    end
  end
end
