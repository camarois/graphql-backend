# .dialyzer_ignore.exs
# about no_return see: https://github.com/jeremyjh/dialyxir/issues/210
[
    # {file, warning_type}
    {"web/router.ex", :no_return}
  ]
  