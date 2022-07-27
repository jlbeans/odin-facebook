# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.destroy_all

User.create(
  first_name: "Emily",
  last_name: "Doe",
  email: "emdoe23@gmail.com",
  password: "Emisbest1!",
  password_confirmation: "Emisbest1!",
  location: "Miami, FL",
  profession: "teacher"
)

User.create(
  first_name: "Jon",
  last_name: "Bonjovi",
  email: "jonnyboy34@gmail.com",
  password: "Joniscool2!",
  password_confirmation: "Joniscool2!",
  location: "Denver, CO",
  profession: "engineer"
)

User.create(
  first_name: "Marty",
  last_name: "Bryd",
  email: "mbryd@gmail.com",
  password: "MartyMoney3!",
  password_confirmation: "MartyMoney3!",
  location: "Portland, OR",
  profession: "financial advisor"
)

User.create(
  first_name: "Wendy",
  last_name: "Bryd",
  email: "wbryd@gmail.com",
  password: "MomOfTheYear4!",
  password_confirmation: "MomOfTheYear4!",
  location: "Portland, OR",
  profession: "full-time mom"
)

User.create(
  first_name: "Jane",
  last_name: "Smith",
  email: "janesmitty@gmail.com",
  password: "JaneGame5!",
  password_confirmation: "JaneGame5!",
  location: "NYC",
  profession: "artist"
)
