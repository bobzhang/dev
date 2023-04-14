
func init {
  // type inference for functions
  let double = fn(x){ x * 2 }
  let small_than = fn(x){ fn(y){ y < x } }

  // create a new list and double each elements, pick those small than 9.
  let ls = [1, 2, 3, 4, 5].stream().map(double).filter(small_than(9)); 
  
  // print each elements by `output_int`
  ls.print_by(output_int)

  "\n sum:".output()
  // use `reduce` to calculate the sum of each elements
  ls.reduce(fn(a,b){ a + b }, 0).output()

  // collect elements of list `ls` into array
  let ary = ls.collect()
}



// return the concatenation of all the elements of two lists.
func concat <X> (self: list<X>, ys: list<X>): list<X> {
  match self {
  | Nil => ys
  | Cons(x, rest) => Cons(x, concat(rest, ys))
  }
}

// apply function `f` to each element of list, collect the results into a new list.
func map <X, Y> (self: list<X>, f: (X) => Y): list<Y> {
  match self {
  | Nil => Nil
  | Cons(x, rest) => Cons(f(x), map(rest, f))
  }
}

// reverse the list.
func reverse <X> (self: list<X>): list<X> {
  fn go (acc, xs: list<X>) {
    match xs {
    | Nil => acc
    | Cons(x, rest) => go(Cons(x, acc), rest)
    }
  }
  go(Nil, self)
}

// apply function `f` to each element of list.
func iter <X> (self: list<X>, f: (X) => unit): unit {
  match self {
  | Nil => ()
  | Cons(x, rest) => f(x); iter(rest, f)
  }
}

// construct list from array.
func stream<T>(self : array<T>): list<T>{
  fn go(idx : int): list<T>{
     if idx == self.length() {
        Nil
     } else {
        Cons(self[idx],go(idx+1))
     }
  }
  go(0)
}

// collect each elements of list into new array
func collect<T>(self : list<T>): array<T>{
  let Cons(x,_) = self
  let ary = array_make(self.length(),x)
  fn go(xs,idx){
    match xs{
    | Nil => ()
    | Cons(x,xs) => ary[idx]=x; go(xs,idx+1)
    }
  }
  ary
}

// returns the list of those elements that satisfy the predicate.
func filter<T>(self : list<T>, predicate : (T)=>bool) : list<T>{
  match self{
  | Nil => Nil
  | Cons(x,xs) => 
      if predicate(x) { 
        Cons(x, filter(xs, predicate)) 
      } else {
        filter(xs,predicate) 
      }
  }
}

// length of list
func length<T>(self : list<T>): int{
  match self{
  | Nil => 0
  | Cons(_,xs) => 1 + xs.length()
  }
}

func reduce<T>(self : list<T>, accumulator : (T,T)=>T, initial : T) : T{
  match self{
  | Nil => initial
  | Cons(x,xs) => reduce(xs, accumulator, accumulator(initial,x))
  }
}

// print each elements of list by `show`.
func print_by<T>(self : list<T>, show : (T)=>unit): unit{
  "[ ".output()
  match self{
  | Nil => ()
  | Cons(h,t) => 
      show(h);
      t.iter(fn(x){", ".output();show(x)})
  }
  " ]".output()
}

