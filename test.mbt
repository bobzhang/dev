
pub func fibXX (n:Int) -> Int {
  match n {
    0 | 1 => 1
    _ => fibXX(n-1)+fibXX(n-2)
  }
}
func init {
  a := 333
  print(fibXX(a))
//  a.output()
}

