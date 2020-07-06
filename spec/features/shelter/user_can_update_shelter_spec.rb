require "rails_helper"


RSpec.describe "Update shelter" do
  before :each do
    @shelter_1 = create(:shelter, state: "CO")
    @shelter_2 = create(:shelter, state: "CA")
  end
  it 'shelter show has link to edit' do
    visit "/shelters/#{@shelter_1.id}"

    click_link "edit"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit")
  end

  it 'edit page has a form' do
    visit "/shelters/#{@shelter_1.id}/edit"

    find_field :name
    find_field :address
    find_field :city
    find_field :state
    find_field :zip

    expect((find_field :name).value).to have_content(@shelter_1.name)
    expect((find_field :address).value).to have_content(@shelter_1.address)
    expect((find_field :city).value).to have_content(@shelter_1.city)
    expect((find_field :state).value).to have_content(@shelter_1.state)
    expect((find_field :zip).value).to have_content(@shelter_1.zip)
  end

  it 'can update the form' do
    visit "/shelters/#{@shelter_1.id}/edit"

    fill_in :name, with: "Kwibes Shelter"
    fill_in :address, with: "2332 MLK"
    fill_in :city, with: "Denver"

    click_on "update"

    expect(page).to have_content("Kwibes Shelter")
    expect(page).to have_content("2332 MLK")
    expect(page).to have_content("Denver")
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)
  end

end
