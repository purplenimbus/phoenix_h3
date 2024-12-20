# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Worbee.Repo.insert!(%Worbee.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Worbee.Game.Words
alias Worbee.Library
alias Worbee.Accounts

Words.read_file("wordle-La.txt")
|> Enum.shuffle()
|> Enum.with_index(fn word, index ->
  {:ok, _daily_answer} =
    Library.create_daily_answer(%{
      date: Date.utc_today() |> Date.add(index),
      word: word
    })
end)

{:ok, admin} =
  Accounts.register_user(%{
    email: "admin@admin.com",
    password: "password1234",
    role: "admin"
  })

  Accounts.grant_admin(admin)

  {:ok, _user} =
    Accounts.register_user(%{
      email: "user@user.com",
      password: "password1234",
      role: ""
    })
