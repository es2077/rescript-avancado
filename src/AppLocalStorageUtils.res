module type Config = {
  type t
  let makeDefault: unit => t
  let encode: t => string
  let decode: string => t
}

module Make = (Config: Config) => {
  let useRehydrate = keyName => {
    let (state, setState) = React.useState(_ => None)

    React.useEffect0(() => {
      setState(_ => Some(
        LocalStorage.getItem(keyName)
        ->Js.Null.toOption
        ->Belt.Option.mapWithDefault(Config.makeDefault(), value => value->Config.decode),
      ))
      None
    })

    let update = (value: Config.t) => {
      LocalStorage.setItem(~key=keyName, value->Config.encode)
      setState(_ => Some(value))
    }

    (state, update)
  }

  module Render = {
    @react.component
    let make = (~value) => {
      value
      ->Belt.Option.mapWithDefault(Config.makeDefault()->Config.encode, Config.encode)
      ->React.string
    }
  }
}
