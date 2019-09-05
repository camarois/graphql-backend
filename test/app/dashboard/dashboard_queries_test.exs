defmodule Backend.App.Dashboard.DashboardQueriesTest do
  use Backend.App.ConnCase
  alias Backend.App.Dashboard

  describe "field queries" do
    @valid_attrs %{
      type: "some type",
      asset: "some asset",
      field_name: "some fieldname",
      field_value: 120.5,
      latitude: 120.5,
      longitude: 120.5,
      timestamp: "some timestamp"
    }

    @query_all """
     query Fields{
       Fields{
         FieldId
         fieldName
         fieldValue
         latitude
         longitude
         timestamp
       }
     }
    """

    @query_one """
      query Field($id: ID) {
            Field(id: $id) {
              FieldId
              fieldName
              fieldValue
              latitude
              longitude
              timestamp
            }
          }
    """

    def field_fixture do
      {:ok, field} = Dashboard.create_field(@valid_attrs)
      field
    end

    test "gets a field by id", context do
      field = field_fixture()
      variables = %{id: field.field_id}

      res =
        context.conn
        |> post("/graphiql", query: @query_one, variables: variables)
        |> json_response(200)
        |> Map.get("data")

      assert res["Field"]["FieldId"] ==
               Integer.to_string(field.field_id)

      assert res["Field"]["fieldName"] == field.field_name
      assert res["Field"]["fieldValue"] == field.field_value
      assert res["Field"]["latitude"] == field.latitude
      assert res["Field"]["longitude"] == field.longitude
      assert res["Field"]["timestamp"] == field.timestamp
    end

    test "gets all fields", context do
      field = field_fixture()

      res =
        context.conn
        |> post("/graphiql", query: @query_all)
        |> json_response(200)
        |> Map.get("data")

      assert Enum.find(res["Fields"], fn child ->
               child["FieldId"] == Integer.to_string(field.field_id)
             end)

      assert Enum.find(res["Fields"], fn child ->
               child["fieldName"] == field.field_name
             end)

      assert Enum.find(res["Fields"], fn child ->
               child["fieldValue"] == field.field_value
             end)

      assert Enum.find(res["Fields"], fn child ->
               child["latitude"] == field.latitude
             end)

      assert Enum.find(res["Fields"], fn child ->
               child["longitude"] == field.longitude
             end)

      assert Enum.find(res["Fields"], fn child ->
               child["timestamp"] == field.timestamp
             end)
    end
  end
end
