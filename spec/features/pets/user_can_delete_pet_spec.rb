require "rails_helper"

RSpec.describe 'user can delete pet', type: :feature do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet , shelter:@shelter_2 )
  end

  it 'can delete pet' do
    visit "/pets/#{@pet_3.id}"

    click_on "Delete Pet"

    expect(current_path).to eq("/pets")
    save_and_open_page

    expect(page).not_to have_content("holie")
  end

  it 'when pet is deleted it is also removed from favorites' do
    visit "/pets/#{@pet_1.id}"

    click_link "add to favorites"

    click_on "Delete Pet"

    visit "/favorites"

    expect(page).to_not have_content("persy")
  end
end
