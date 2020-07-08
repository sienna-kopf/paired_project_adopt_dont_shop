require "rails_helper"

RSpec.describe 'user can edit reviews' do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet ,name: "Harry", shelter:@shelter_2 )
    @review_1 = create(:review, shelter:@shelter_2 )
    @review_2 = create(:review, shelter:@shelter_2 )
    @review_3 = create(:review, shelter:@shelter_2 )
    @review_4 = create(:review, shelter:@shelter_2 )
  end
  it 'go to edit page' do
    visit "/shelters/#{@shelter_2.id}"
    expect(page).to have_link("edit review")

    within "div#review_#{@review_1.id}" do
      click_on "edit review"
    end
    expect(current_path).to eq("/shelters/reviews/#{@review_1.id}/edit")

    visit "/shelters/#{@shelter_2.id}"

    expect(page).to have_link("edit review")

    within "div#review_#{@review_2.id}" do
      click_on "edit review"
    end
    expect(current_path).to eq("/shelters/reviews/#{@review_2.id}/edit")

    visit "/shelters/#{@shelter_2.id}"

    expect(page).to have_link("edit review")

    within "div#review_#{@review_3.id}" do
      click_on "edit review"
    end
    expect(current_path).to eq("/shelters/reviews/#{@review_3.id}/edit")
  end

  it 'should update the review' do
    visit "/shelters/reviews/#{@review_1.id}/edit"

    expect((find_field :title).value).to eq(@review_1.title)
    expect((find_field :content).value).to eq(@review_1.content)
    expect((find_field :rating).value).to eq(@review_1.rating.to_s)

    fill_in :title, with: "simple responsive footer"
    fill_in :rating, with: "5"
    fill_in :content, with: "The Bulma footer is a simple container, with lots of bottom padding, making it great as the last element of any webpage."

    click_on "update review"

    expect(current_path).to eq("/shelters/#{@shelter_2.id}")

    expect(page).to have_content("The Bulma footer is a simple container, with lots of bottom padding, making it great as the last element of any webpage.")
    expect(page).to have_content("5")
    expect(page).to have_content("simple responsive footer")
  end
end
