# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

team_members = TeamMember.create([{name: "Nikesh", slack_name: "nikesh", image_path: "https://avatars2.githubusercontent.com/u/7963753"},
  {name: "Arfah", slack_name: "arfah", image_path: "http://www.makersacademy.com/images/people/team/arfah.jpg"},
  {name: "Evgeny", slack_name: "evgeny", image_path: "http://www.makersacademy.com/images/people/team/evgeny.jpg"},
  {name: "Will", slack_name: "w", image_path: "https://avatars3.githubusercontent.com/u/2176170"},
  {name: "Spike", slack_name: "spike", image_path: "https://avatars3.githubusercontent.com/u/7307631"},
  {name: "Ruben", slack_name: "ruben", image_path: "http://www.makersacademy.com/images/people/team/ruben.jpg"},
  {name: "Jordan", slack_name: "jordanmaker", image_path: "http://www.makersacademy.com/images/people/team/jordan.jpg"},
  {name: "Not known", slack_name: "channel", image_path: "/public/images/logo-red-circle.png"}])

User.create(name: "Timmy", phone_id: "asdf")