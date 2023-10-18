
pub func fibXX (n:int) -> int {
  match n {
    0 | 1 => 1
    _ => fibXX(n-1)+fibXX(n-2)
  }
}
func init {
  let a = 33
  fibXX(a).print()
//  a.output()
}

