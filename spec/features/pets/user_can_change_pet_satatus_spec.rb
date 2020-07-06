require "rails_helper"

RSpec.describe "user can change pet status", type: :feature do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet , shelter:@shelter_2 )
  end
  it 'can change status' do
    visit "/pets/#{@pet_2.id}"

    expect(page).to have_link("change to pending")

    click_link "change to pending"

    expect(current_path).to eq("/pets/#{@pet_2.id}")
    within "div.card-content" do
      expect(page).to have_content("pending")
    end

    click_link "change to adoptible"

    expect(current_path).to eq("/pets/#{@pet_2.id}")
    within "div.card-content" do
      expect(page).to have_content("adoptible")
    end
  end

end
