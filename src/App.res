module ConfigDate = {
  type t = Js.Date.t
  let encode = date => {
    date->Js.Date.getTime->Js.Float.toString
  }
  let decode = str => {
    str->Js.Float.fromString->Js.Date.fromFloat
  }

  let makeDefault = () => Js.Date.make()
}

module DateRehydrate = AppLocalStorageUtils.Make(ConfigDate)

@react.component
let make = () => {
  let (date, updateDate) = DateRehydrate.useRehydrate("date")

  <div className="main-container">
    <p> {"The last saved date is "->React.string} <DateRehydrate.Render value={date} /> </p>
    <button
      onClick={_ => {
        updateDate(Js.Date.make())
      }}>
      {"Update date"->React.string}
    </button>
  </div>
}
