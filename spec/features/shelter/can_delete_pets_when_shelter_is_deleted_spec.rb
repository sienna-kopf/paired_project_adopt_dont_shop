require "rails_helper"

RSpec.describe 'delere asociated pets with shelter' , type: :feature do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet ,name: "Harry", shelter:@shelter_2 )
  end

  it 'can delete pets when shelter is deleted' do
    visit "/shelters"

    within "div#shelter_#{@shelter_1.id}" do
      click_on "Delete"
    end

    visit "/pets"

    expect(page).not_to have_content("persy")
    expect(page).not_to have_content("holie")

    expect(page).to have_content("piper")
    expect(page).to have_content("Harry")
  end
end
