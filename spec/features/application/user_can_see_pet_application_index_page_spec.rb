require "rails_helper"

RSpec.describe "application show page", type: :feature do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet, name: "thea", age: 17, sex: "female", shelter: @shelter_2)
    @pet_5 = create(:pet , shelter:@shelter_2 )
    @application_1 = Applicant.create!(name: "kwibe merci", address: "3478 MLK", city: "Denver", state: "CO", zip: "34526", phonenumber: "3452690876", description: "I love the pets. They will be my new babies ❤️")
    @application_2 = Applicant.create!(name: "cece kopf", address: "444 sport ave", city: "Salt Lake City", state: "UT", zip: "12345", phonenumber: "3033333333", description: "Loving home. Human  best friend for life.")
    @favorite = Favorite.new(Array.new(0))
  end

  it 'can see information about an application' do
    @favorite.add_pet(@pet_1)
    @favorite.add_pet(@pet_2)
    @favorite.add_pet(@pet_3)

    @application_1.pets << @pet_1
    @application_1.pets << @pet_2

    @application_2.pets << @pet_1
    @application_2.pets << @pet_3

    visit "/pets/#{@pet_1.id}"

    click_on "view applications for #{@pet_1.name}"

    expect(current_path).to eq("/pets/#{@pet_1.id}/applications")
    expect(page).to have_link("kwibe merci")
    expect(page).to have_link("cece kopf")

    click_on "cece kopf"

    expect(current_path).to eq("/applications/#{@application_2.id}")
  end

  it "displays a message if there are no applications for a pet" do
    visit "/pets/#{@pet_4.id}/applications"

    expect(page).to have_content("no current applications for #{@pet_4.name}")
    expect(page).to_not have_link("kwibe merci")
  end
end
