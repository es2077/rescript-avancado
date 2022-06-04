module type Config = {
  type t
  let makeDefault: unit => t
  let encode: t => string
  let decode: string => t
}

let useRehydrate:
  type state. (module(Config with type t = state), string) => (option<state>, state => unit) =
  (module(Config), keyName) => {
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

let render:
  type state. (module(Config with type t = state), option<state>) => React.element =
  (module(Config), value) => {
    value
    ->Belt.Option.mapWithDefault(Config.makeDefault()->Config.encode, Config.encode)
    ->React.string
  }
