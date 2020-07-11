require "rails_helper"

RSpec.describe "application show page", type: :feature do
  before :all do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet , shelter:@shelter_2 )
    @application = Applicant.create!(name: "kwibe merci", address: "3478 MLK", city: "Denver", state: "CO", zip: "34526", phonenumber: "3452690876", description: "I love the pets. They will be my new babies ❤️" )
  end

  it 'can see information about an application' do
    visit "/pets/#{@pet_2.id}"
    click_link "add to favorites"
    visit "/pets/#{@pet_1.id}"
    click_link "add to favorites"
    visit "/pets/#{@pet_3.id}"
    click_link "add to favorites"

    visit '/favorites'
    click_on 'adopt favorites'

    within(".checkbox-#{@pet_1.id}") do
      find("input[type='checkbox'][value='#{@pet_1.id}']").set(true)
    end

    within(".checkbox-#{@pet_2.id}") do
      find("input[type='checkbox'][value='#{@pet_2.id}']").set(true)
    end

    within(".checkbox-#{@pet_3.id}") do
      find("input[type='checkbox'][value='#{@pet_3.id}']").set(false)
    end

    fill_in :name, with: "kwibe merci"
    fill_in :address, with: "3478 MLK"
    fill_in :city, with: "Denver"
    select "CO", from: :state
    fill_in :zip, with: "34526"
    fill_in :phonenumber, with: "3452690876"
    fill_in :description, with: "I love the pets. They will be my new babies ❤️"

    click_on "submit"

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
