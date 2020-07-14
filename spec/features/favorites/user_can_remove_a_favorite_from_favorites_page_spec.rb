
require "rails_helper"

RSpec.describe 'favorite removal', type: :feature do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet , shelter:@shelter_2 )

    visit "/pets/#{@pet_1.id}"
      click_on "add to favorites"
    visit "/pets/#{@pet_2.id}"
      click_on "add to favorites"
    visit "/pets/#{@pet_3.id}"
      click_on "add to favorites"
  end

  it 'can remove a pet from favorites' do
    visit "/favorites"

    expect(page).to have_content("favorites: 3")
    expect(page).to have_link("#{@pet_1.name}")

    within("#pet-#{@pet_1.id}") do
      click_link "remove from favorites"
    end

    expect(page).to have_content("You have removed #{@pet_1.name} from favorites")
    within ".is-vertical" do
      expect(page).to_not have_link("#{@pet_1.name}")
    end
    expect(current_path).to eq("/favorites")
  end
end
