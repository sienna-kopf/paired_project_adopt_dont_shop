require "rails_helper"

RSpec.describe 'shelter can update pet', type: :feature do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet , shelter:@shelter_2 )
  end

  it 'can link to edit page' do
    visit "/pets/#{@pet_1.id}"

    click_on "Update Pet"

    expect(current_path).to eq("/pets/#{@pet_1.id}/edit")
  end

  it 'can update pet ' do
    visit "/pets/#{@pet_2.id}/edit"

    fill_in :name, with: "Harry Molly"
    fill_in :age, with: "4"
    select "male", from: :sex

    click_on "Update Pet"

    expect(current_path).to eq("/pets/#{@pet_2.id}")

    expect(page).to have_content("Harry Molly")
    expect(page).to have_content("4")
    expect(page).to have_content("male")
  end
end
