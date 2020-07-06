require "rails_helper"

RSpec.describe 'user deletes a shelter' do
  before :each do
    @shelter_1 = create(:shelter, name: "Kwibe Merci")
    @shelter_2 = create(:shelter)
  end
  it 'shelter show has a delete link' do
    visit "/shelters/#{@shelter_1.id}"

    find_link "delete"
  end

  it 'delete shelter' do
    visit "/shelters/#{@shelter_1.id}"

    click_link "delete"

    expect(current_path).to eq("/shelters")
    expect(page).not_to have_content("Kwibe Merci")
  end

end
