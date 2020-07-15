require "rails_helper"

RSpec.describe "user can create application", type: :feature do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet , shelter:@shelter_2 )

    visit "/pets/#{@pet_2.id}"
    click_link "add to favorites"
    visit "/pets/#{@pet_1.id}"
    click_link "add to favorites"
  end

  it 'has link to adopt' do
    visit '/favorites'

    click_on 'adopt favorites'

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("persy")
    expect(page).to have_content("piper")

    fill_in :name, with: "kwibe merci"
    fill_in :address, with: "3478 MLK"
    fill_in :city, with: "Denver"
    select "CO", from: :state
    fill_in :zip, with: "34526"
    fill_in :phonenumber, with: "3452690876"
    fill_in :description, with: "I love the pets. They will be my new babies ❤️"

    click_on "submit"
    expect(page).to have_content("Application has gone through")
    expect(current_path).to have_content("/favorites")
    expect(page).to have_content("no favorited pets")
  end

  it 'throws errors if incomplete form' do
    visit '/applications/new'

    fill_in :name, with: "kwibe merci"
    fill_in :address, with: ""
    fill_in :city, with: "Denver"
    select "CO", from: :state
    fill_in :zip, with: "34526"
    fill_in :phonenumber, with: ""
    fill_in :description, with: "I love the pets. They will be my new babies ❤️"

    click_on "submit"

    expect(page).to have_content("Address can't be blank")
    expect(page).to have_content("Phonenumber can't be blank")
  end
end
