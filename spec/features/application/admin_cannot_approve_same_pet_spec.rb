require "rails_helper"

RSpec.describe "approve pet twice", type: :feature do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet , shelter:@shelter_2 )
    @application = create(:applicant)
    @application_2 = create(:applicant)
    @application.pets << [@pet_2, @pet_1]
    @application_2.pets << [@pet_2, @pet_3, @pet_1]
  end

  it 'cannot approve a pet twice' do
    visit "/applications/#{@application_2.id}"

    expect(page).to have_link(@pet_2.name)
    expect(page).to have_link(@pet_1.name)
    expect(page).to have_link(@pet_3.name)

    within "div#pet_#{@pet_1.id}" do
      click_on "Approve"
    end

    visit "/applications/#{@application.id}"

    within "div#pet_#{@pet_1.id}" do
      click_on "Approve"
    end

    expect(page).to have_content("No more applications can be approved for #{@pet_1.name} at this time")

  end
end
