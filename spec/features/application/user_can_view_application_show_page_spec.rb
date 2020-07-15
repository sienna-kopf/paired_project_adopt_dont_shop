require "rails_helper"

RSpec.describe "application show page", type: :feature do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet , shelter:@shelter_2 )
    @application = Applicant.create!(name: "kwibe merci", address: "3478 MLK", city: "Denver", state: "CO", zip: "34526", phonenumber: "3452690876", description: "I love the pets. They will be my new babies ❤️" )
    @application.pets << [@pet_2, @pet_1]
  end

  it 'can see information about an application' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("kwibe merci")
    expect(page).to have_content("3478 MLK")
    expect(page).to have_content("Denver")
    expect(page).to have_content("CO")
    expect(page).to have_content("34526")
    expect(page).to have_content("3452690876")
    expect(page).to have_content("I love the pets. They will be my new babies ❤️")
    expect(page).to have_link("persy")
    expect(page).to have_link("piper")
  end
end
