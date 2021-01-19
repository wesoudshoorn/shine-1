import shine/test.{Test}
import gleam/should
import gleam/function
import gleam/dynamic
import gleam/atom

pub fn run_test() {
  assert Ok(dynamic_result) =
    test.run(Test(module: "shine_test", name: "passing_test", run: passing))

  assert Ok(result) = dynamic.string(dynamic_result)

  result
  |> should.equal("")
}

pub fn wrap_passing_test() {
  test.wrap(fn() {
    1
    |> should.equal(1)
  })()
  |> should.be_ok
}

pub fn wrap_failing_test() {
  let Error(tuple(kind, error, stack)) =
    test.wrap(fn() {
      1
      |> should.equal(2)
    })()

  let Ok(tuple(dynamic_kind, _)) = dynamic.tuple2(error)
  let Ok(error_kind) = dynamic.atom(dynamic_kind)

  kind
  |> atom.to_string()
  |> should.equal("errored")

  error_kind
  |> atom.to_string()
  |> should.equal("assertEqual")

  stack
  |> dynamic.list
  |> should.be_ok
}

fn passing() {
  Ok(dynamic.from(""))
}
