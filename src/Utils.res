/**
 * Introdução
 * Sintaxe de uma functor em ReScript
 * Criando nossa primeira functor em ReScript
 * Entendendo o module type e o functor
 * O nome functor
 * Quando utilizar uma functor
 * Preciso entender functors 100% pra usar functors?
 * Exemplos de bibliotecas com functors
 */

module type Config = {
  type t
  let toString: t => string
}

module MakeHello = (Config: Config) => {
  let sayHello = value => {
    Js.log(`Hello, ${value->Config.toString}`)
  }
}

type user = {
  firstName: string,
  lastName: string,
}

module UserHelloConfig = {
  type t = user
  let toString = (user: t) => `${user.firstName} ${user.lastName}`
}

module UserHello = MakeHello(UserHelloConfig)

let gabriel = {
  firstName: "Gabriel",
  lastName: "Santos",
}

gabriel->UserHello.sayHello
