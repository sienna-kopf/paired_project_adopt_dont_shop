require 'rails_helper'

RSpec.describe 'visit /shelter/:id', type: :feature do
  describe 'can create new shelters' do
    it 'can link to /new' do
      visit "/shelters"

      click_link "New Shelter"
      expect(current_path).to eq("/shelters/new")

      find_field(:name)
      find_field(:address)
      find_field(:city)
      find_field(:state)
      find_field(:zip)
    end

    it 'did not save shelter' do
      visit "/shelters/new"
      fill_in :city, with: "Heaneyville"
      select "IN", from: :state
      fill_in :zip, with: "76025"

      click_button "Submit"
      expect(current_path).to eq("/shelters/new")
    end

    it 'can create shelter' do
      visit "/shelters/new"

      fill_in :name, with: "The Dark Knight Returns 23"
      fill_in :address, with:"759 Balistreri Walk, Heaneyville, IN 76025"
      fill_in :city, with: "Heaneyville"
      select "IN", from: :state
      fill_in :zip, with: "76025"

      click_button "Submit"


      expect(current_path).to eq("/shelters")
      expect(page).to have_content("The Dark Knight Returns 23")
    end
  end
end
