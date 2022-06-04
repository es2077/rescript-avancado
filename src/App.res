module DateRehydrate = {
  type t = Js.Date.t
  let encode = date => {
    date->Js.Date.getTime->Js.Float.toString
  }
  let decode = str => {
    str->Js.Float.fromString->Js.Date.fromFloat
  }

  let makeDefault = () => Js.Date.make()
}

@react.component
let make = () => {
  let (date, updateDate) = AppLocalStorageUtils.useRehydrate(module(DateRehydrate), "date")

  <div className="main-container">
    <p>
      {"The last saved date is "->React.string}
      {AppLocalStorageUtils.render(module(DateRehydrate), date)}
    </p>
    <button
      onClick={_ => {
        updateDate(Js.Date.make())
      }}>
      {"Update date"->React.string}
    </button>
  </div>
}
