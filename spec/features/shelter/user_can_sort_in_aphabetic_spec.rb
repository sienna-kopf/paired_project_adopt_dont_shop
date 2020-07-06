require "rails_helper"

RSpec.describe '', type: :feature do
  before :each do
    @shelter_1 = create(:shelter, name: "Pet Finder", state: "CO")
    @shelter_2 = create(:shelter, name: "adopt best")
    @shelter_3 = create(:shelter, name: 'We love animals')
    @shelter_4 = create(:shelter, name: 'cutest lovies')
  end

  it 'can sort alphabetically' do
    visit "/shelters"

    click_on "sort A-Z"

    within "div.card:nth-child(1)" do
      expect(page).to have_content("adopt best")
    end

    within "div.card:nth-child(2)" do
      expect(page).to have_content("cutest lovies")
    end

    within "div.card:nth-child(3)" do
      expect(page).to have_content("Pet Finder")
    end

    within "div.card:nth-child(4)" do
      expect(page).to have_content("We love animals")
    end
  end

end
