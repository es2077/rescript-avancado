@val
external setItem: (~key: string, string) => unit = "localStorage.setItem"

@val
external getItem: string => Js.Null.t<string> = "localStorage.getItem"
