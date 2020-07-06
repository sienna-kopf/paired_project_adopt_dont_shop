require 'rails_helper'

RSpec.describe 'visit /shelter/:id', type: :feature do
  before :each do
    @shelter_1 = create(:shelter)
  end
  describe "sees all shelters" do
    it 'display all shelters' do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_1.address)
      expect(page).to have_content(@shelter_1.state)
      expect(page).to have_content(@shelter_1.city)
      expect(page).to have_content(@shelter_1.zip)
    end
  end
end
