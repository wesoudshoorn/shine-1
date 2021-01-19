import shine.{TestModule}
import shine/test.{Test}
import gleam/should
import gleam/dynamic

pub fn run_test() {
  let suite = [
    TestModule(
      name: "test",
      tests: [
        Test(
          module: "shine_test",
          name: "passing_test",
          run: fn() { Ok(dynamic.from("")) },
        ),
      ],
    ),
  ]
  assert [tuple("test", [result])] = shine.run(suite)

  result
  |> should.be_ok()
}
