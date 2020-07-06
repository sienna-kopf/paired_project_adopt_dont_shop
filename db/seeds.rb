# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require "factory_bot_rails"
include FactoryBot::Syntax::Methods


@shelter_1 = create(:shelter)
@shelter_2 = create(:shelter)
@shelter_3 = create(:shelter)
@shelter_4 = create(:shelter)

 create_list(:pet, 6, shelter: @shelter_1)
 create_list(:pet, 8, shelter: @shelter_2)
 create_list(:pet, 9, shelter: @shelter_3)
 create_list(:pet, 12, shelter: @shelter_4)
