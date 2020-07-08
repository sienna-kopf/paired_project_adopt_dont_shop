require "rails_helper"

RSpec.describe "User can see errirs", type: :feature do
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

  it 'can display one error' do
    visit "/shelters/reviews/#{@review_1.id}/edit"

    fill_in :title, with: "simple responsive footer"
    fill_in :rating, with: ""
    fill_in :content, with: "The Bulma footer is a simple container, with lots of bottom padding, making it great as the last element of any webpage."

    click_on "update review"

    expect(current_path).to eq("/shelters/reviews/#{@review_1.id}/edit")

    expect(page).to have_content("Rating can't be blank")
  end

  it 'can display multiple errors' do
    visit "/shelters/reviews/#{@review_1.id}/edit"

    fill_in :title, with: ""
    fill_in :rating, with: ""
    fill_in :content, with: "The Bulma footer is a simple container, with lots of bottom padding, making it great as the last element of any webpage."

    click_on "update review"

    expect(current_path).to eq("/shelters/reviews/#{@review_1.id}/edit")

    expect(page).to have_content("Rating can't be blank")
    expect(page).to have_content("Title can't be blank")
  end
end
