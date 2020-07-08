require 'rails_helper'

RSpec.describe "user can create review", type: :feature do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
  end

  it "can follow link to form for new review " do
    visit "/shelters/#{@shelter_1.id}"

    click_on "add review"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/new")
  end

  it "can create a new review" do
    visit "/shelters/#{@shelter_1.id}/new"

    fill_in :title, with: "Great Experience"
    fill_in :rating, with: 4
    fill_in :content, with: "Friendly staff, organized."
    fill_in :image, with: "smiley.jpg"

    click_on "submit review"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")

    expect(page).to have_content("Great Experience")
    expect(page).to have_content(4)
    expect(page).to have_content("Friendly staff, organized.")
    expect(page).to have_css("img[src*='smiley.jpg']")
  end

  it "can not submit a review with one incomplete field" do
    visit "/shelters/#{@shelter_1.id}/new"

    fill_in :title, with: ""
    fill_in :rating, with: 4
    fill_in :content, with: "Friendly staff, organized."

    click_on "submit review"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/new")
    expect(page).to have_content("Title can't be blank")
  end

  it "can not sumbit a review with multiple incomplete fields" do
    visit "/shelters/#{@shelter_1.id}/new"

    fill_in :title, with: "Great Experience"
    fill_in :rating, with: ""
    fill_in :content, with: ""

    click_on "submit review"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/new")
    expect(page).to have_content("Rating can't be blank")
    expect(page).to have_content("Content can't be blank")
  end

  it "can submit a review without an image" do
    visit "/shelters/#{@shelter_1.id}/new"

    fill_in :title, with: "Great Experience"
    fill_in :rating, with: 4
    fill_in :content, with: "Friendly staff, organized."

    click_on "submit review"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).to have_content("Great Experience")
    expect(page).to have_content("Friendly staff, organized.")
  end
end
