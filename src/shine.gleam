import gleam/function.{Exception}
import gleam/list
import gleam/io
import gleam/dynamic.{Dynamic}
import gleam/string
import shine/test.{Test}

pub type TestModule {
  TestModule(name: String, tests: List(Test))
}

pub fn init(state) {
  assert Ok(state) = rebar3_shine_init(state)
  Ok(state)
}

pub fn run_suite(
  suite: List(TestModule),
) -> List(tuple(String, List(Result(Dynamic, Exception)))) {
  list.map(
    suite,
    fn(test_module: TestModule) {
      tuple(test_module.name, list.map(test_module.tests, test.run))
    },
  )
}

external fn rebar3_shine_init(state) -> state =
  "rebar3_shine" "init"
