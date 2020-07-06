require 'rails_helper'

RSpec.describe 'visit /shelter', type: :feature do
  describe "sees all shelters" do
    it 'display all shelters' do
      shelter_1 = create(:shelter)
      shelter_2 = create(:shelter)
      shelter_3 = create(:shelter)
      visit "/shelters"
      within "div#shelter_#{shelter_1.id}" do
        expect(page).to have_link(shelter_1.name)
        expect(page).to have_button("Delete")
      end
      within "div#shelter_#{shelter_2.id}" do
        expect(page).to have_link(shelter_2.name)
        expect(page).to have_button("Delete")
      end
      within "div#shelter_#{shelter_3.id}" do
        expect(page).to have_link(shelter_3.name)
        expect(page).to have_button("Delete")
      end
    end

  end
end
