
require "rails_helper"

RSpec.describe 'favorite creation', type: :feature do
  before :all do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet , shelter:@shelter_2 )
  end

  it 'can add to favorites' do
    visit "/pets/#{@pet_2.id}"

    expect(page).to have_link("add to favorites")

    click_on "add to favorites"

    expect(current_path).to eq("/pets/#{@pet_2.id}")

    within('nav') do
      expect(page).to have_content("favorites: 1")
    end
    expect(page).to have_content("You have added #{@pet_2.name} to favorites")

    visit "/pets/#{@pet_1.id}"

    click_on "add to favorites"

    within('nav') do
      expect(page).to have_content("favorites: 2")
    end
    expect(page).to have_content("You have added #{@pet_1.name} to favorites")
  end
end
