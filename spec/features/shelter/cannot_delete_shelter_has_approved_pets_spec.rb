require "rails_helper"

RSpec.describe "approve pet", type: :feature do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @application = create(:applicant)
    @application_2 = create(:applicant)
    @application.pets << [@pet_2, @pet_1]
    @application_2.pets << [@pet_2, @pet_3, @pet_1]
  end

  it 'cannot delete pet' do
    visit "/applications/#{@application_2.id}"

    within "div#pet_#{@pet_2.id}" do
      click_on 'Approve'
    end

    visit "/shelters/#{@shelter_2.id}"

    click_link "delete"

    expect(page).to have_content("Cannot delete: Shelter has pending application")

  end

end
