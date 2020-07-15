require "rails_helper"

RSpec.describe 'see top rated shelters' do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @shelter_3 = create(:shelter)
    @shelter_4 = create(:shelter)
    @shelter_5 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_2)
    @pet_4 = create(:pet, shelter: @shelter_3)
    @pet_5 = create(:pet, shelter: @shelter_3)
    @pet_6 = create(:pet, shelter: @shelter_4)
    @pet_7 = create(:pet, shelter: @shelter_5)
    @review_1 = create(:review, title: "Great Experience!" , rating: 4, content: "Clean, Friendly staff.", shelter: @shelter_1)
    @review_2 = create(:review, title: "Very organized" , rating: 4, content: "Easy to find a pet I love.", shelter: @shelter_2)
    @review_3 = create(:review, title: "The pets are great!", rating: 3, content: "Loved the pet names.", shelter: @shelter_2)
    @review_4 = create(:review, title: "Could have more variety.", rating: 2, content: "Lots of the pets looked very similar.", shelter: @shelter_3)
    @review_5 = create(:review, title: "Let’s see if we can put ", rating: 1, content: "Lots of the pets looked very similar.", shelter: @shelter_1)
    @review_4 = create(:review, title: "Call this together to DRY up our.", rating: 5, content: "Lots of the pets looked very similar.", shelter: @shelter_4)
    @review_4 = create(:review, title: "Now, we are sending our render method.", rating: 0, content: "Lots of the pets looked very similar.", shelter: @shelter_3)
    @review_4 = create(:review, title: "When rendering a partial.", rating: 0, content: "Lots of the pets looked very similar.", shelter: @shelter_5)
    @review_4 = create(:review, title: "Thinking about plain Ruby", rating: 4, content: "Lots of the pets looked very similar.", shelter: @shelter_1)
  end

  it 'display top rated shelters' do
    visit "/shelters"

    expect(page).to have_content("Best Rating Shelters")

    within "aside#best_rating" do
      expect(page).to have_link(@shelter_4.name)
      expect(page).to have_link(@shelter_2.name)
      expect(page).to have_link(@shelter_1.name)
    end

  end
end
