require "rails_helper"

RSpec.describe "user can see list of pets with current applications", type: :feature do
  before :all do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet , shelter:@shelter_2 )
  end

  it 'displays a list of pets that have current applications' do
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

    visit "/favorites"

    within("section#application_pets") do
      expect(page).to have_link("persy")
      expect(page).to have_link("piper")
      expect(page).to_not have_link("holie")
    end

    click_on "persy"

    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end
end
