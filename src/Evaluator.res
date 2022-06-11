type rec value<_> = Bool(bool): value<bool> | Int(int): value<int>

type rec expression<_> =
  // Value = value<'a> => expression<'a>
  | Value(value<'a>): expression<'a>
  // Value = {cond, body, expression} => expression<'a>
  | If({cond: expression<bool>, body: expression<'a>, else_: expression<'a>}): expression<'a>
  | Eq(expression<'a>, expression<'a>): expression<bool>
  | Lt(expression<int>, expression<int>): expression<bool>

let program = {
  If({
    cond: Lt(Value(Int(42)), Value(Int(22))),
    body: Value(Int(12)),
    else_: Value(Int(42)),
  })
}

// let invalidProgram = {
//   If({
//     cond: Lt(Value(Int(42)), Value(Int(22))),
//     body: If({
//       cond: Lt(Value(Int(42)), Value(Int(22))),
//       body: Value(Bool(true)),
//       else_: Value(Bool(false)),
//     }),
//     else_: Value(Int(42)),
//   })
// }

let rec eval:
  type a. expression<a> => a =
  x =>
    switch x {
    | Value(Bool(b)) => b
    | Value(Int(i)) => i
    | If({cond: b, body: l, else_: r}) =>
      if eval(b) {
        eval(l)
      } else {
        eval(r)
      }
    | Eq(a, b) => eval(a) == eval(b)
    | Lt(a, b) => eval(a) < eval(b)
    }

// let a = eval(invalidProgram)

// let rec eval: expression => value = expression => {
//   switch expression {
//   | Value(v) => v
//   | Lt(x, y) =>
//     switch (eval(x), eval(y)) {
//     | (Int(x), Int(y)) => Bool(x < y)
//     | (Int(_), Bool(_))
//     | (Bool(_), Int(_))
//     | (Bool(_), Bool(_)) =>
//       failwith("Invalid AST")
//     }
//   | If({cond: b, body: l, else_: r}) =>
//     switch eval(b) {
//     | Bool(true) => eval(l)
//     | Bool(false) => eval(r)
//     | Int(_) => failwith("Invalid AST")
//     }
//   | Eq(a, b) =>
//     switch (eval(a), eval(b)) {
//     | (Int(x), Int(y)) => Bool(x == y)
//     | (Bool(_), Bool(_))
//     | (Bool(_), Int(_))
//     | (Int(_), Bool(_)) =>
//       failwith("Invalid AST")
//     }
//   }
// }

// let a = eval(program)
