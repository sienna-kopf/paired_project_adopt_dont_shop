
require "rails_helper"

RSpec.describe "user can see reviews", type: :feature do
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
    @review_4 = create(:review, image: Faker::Avatar.image( size: "100x100", format: "jpg"), shelter:@shelter_2 )
  end

  it 'should display all reviews' do
    visit "/shelters/#{@shelter_2.id}"

    expect(page).to have_content(@review_1.title)
    expect(page).to have_content(@review_1.content)
    expect(page).to have_content(@review_1.rating)

    expect(page).to have_content(@review_2.title)
    expect(page).to have_content(@review_2.content)
    expect(page).to have_content(@review_2.rating)

    expect(page).to have_content(@review_3.title)
    expect(page).to have_content(@review_3.content)
    expect(page).to have_content(@review_3.rating)

    expect(page).to have_content(@review_4.title)
    expect(page).to have_content(@review_4.content)
    expect(page).to have_content(@review_4.rating)
    expect(page).to have_css("img[src*='#{@review_4.image}']")

  end

end
