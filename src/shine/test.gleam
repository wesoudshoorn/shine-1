import gleam/function.{Exception}
import gleam/atom.{Atom}
import gleam/dynamic.{Dynamic}

pub type Test {
  Test(module: String, name: String, run: fn() -> Result(Dynamic, Exception))
}

pub fn run(test: Test) -> Result(Dynamic, Exception) {
  test.run()
}

pub fn wrap(fun: fn() -> a) {
  fn() { rescue(fun) }
}

pub external fn rescue(fn() -> a) -> Result(a, tuple(Atom, Dynamic, Dynamic)) =
  "shine_external" "rescue"
