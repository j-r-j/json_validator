defmodule PersonTest do
  use ExUnit.Case, async: true

  alias Person, as: Subject

  describe "json_conversion/1" do
    test "method given valid Json it returns a tuple that includes :ok and params" do
      valid_json_string =
        ~s({"birthday": "2012-04-23T18:25:43.511Z", "name": "foo bar baz", "sources": [{"site": "foo", "name": "bar"}], "identifiers": [{"value": "baz"}, {"value": "alpha"}]})

      assert {:ok, ecto_changeset} = Subject.json_conversion(valid_json_string)
    end

    test "method given valid Json it returns a tuple that includes :error and tuples" do
      valid_json_string =
        ~s({"birthday": "2012-04-23T18:25:43.511Z", "nam": "foo bar baz", "sources": [{"site": "foo", "name": "bar"}], "identifiers": [{"value": "baz"}, {"value": "alpha"}]})

      assert {:error, ecto_changeset} = Subject.json_conversion(valid_json_string)
    end
  end
end
