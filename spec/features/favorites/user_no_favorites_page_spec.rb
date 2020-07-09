require "rails_helper"

RSpec.describe 'no favorites page', type: :feature do
  before :all do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet , shelter:@shelter_2 )
  end

  it 'can display message on favorites page, when there are no favorites' do
    visit "/favorites"

    within('nav') do
      expect(page).to have_content("favorites: 0")
    end

    expect(page).to have_content("no favorited pets")
  end
end
