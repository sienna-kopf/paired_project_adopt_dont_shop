require "rails_helper"

RSpec.describe 'Shelter can create a pet' do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
  end

  it 'has a link to create new pets' do
    visit "/shelters/#{@shelter_2.id}"

    click_on "Create Pet"

    expect(current_path).to eq("/shelters/#{@shelter_2.id}/pets/new")
  end

  it 'can create pets' do
    visit "/shelters/#{@shelter_2.id}/pets/new"

    fill_in :name , with: "Percy"
    fill_in :description , with: " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer sed diam nec urna faucibus semper. Donec eget ipsum a sapien tincidunt vestibulum vel non purus."
    select "male", from: :sex
    fill_in :age , with: "8"
    fill_in :image , with: "percy.jpg"

    click_on "Create Pet"
    new_pet = Pet.last
    expect(current_path).to eq("/pets")

    within "div#pet_#{new_pet.id}" do
      expect(page).to have_link(@shelter_2.name)
      expect(page).to have_content("adoptible")
      expect(page).to have_content("Percy")
      expect(page).to have_content("male")
      expect(page).to have_content("Lorem ipsum dolor sit amet")
      expect(page).to have_content("8")
      expect(page).to have_css("img[src*='percy.jpg']")
    end
  end

  it 'displays flash message when one form field is incomplete' do
    visit "/shelters/#{@shelter_2.id}/pets/new"

    fill_in :name , with: "Percy"
    fill_in :description , with: ""
    select "male", from: :sex
    fill_in :age , with: "8"
    fill_in :image , with: "percy.jpg"

    click_on "Create Pet"

    expect(page).to have_content("Description can't be blank")
  end

  it 'displays flash message when multiple form fields are incomplete' do
    visit "/shelters/#{@shelter_2.id}/pets/new"

    fill_in :name , with: ""
    fill_in :description , with: ""
    select "male", from: :sex
    fill_in :age , with: "4"

    click_on "Create Pet"

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(page).to have_content("Image can't be blank")
  end
end
