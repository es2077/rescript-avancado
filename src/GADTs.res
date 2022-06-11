type state = {
  email: string,
  age: int
}

type rec field<_> = Email: field<string> | Age: field<int>
// Email: unit => field<string>
// Age: unit => field<int>

let get: type value. (state, field<value>) => value = (state, field) => {
  switch(field) {
    | Email => state.email
    | Age => state.age
  }
}

let foo = {
  email: "hello@tld.com",
  age: 25,
}


let emailValue: string = foo->get(Email)
let ageValue: int = foo->get(Age)