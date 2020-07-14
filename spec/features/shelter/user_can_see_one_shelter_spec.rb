require 'rails_helper'

RSpec.describe 'visit /shelter/:id', type: :feature do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_2)
    @pet_4 = create(:pet, name: "harry", age: 5, sex: "male", shelter: @shelter_2)
    @review_1 = create(:review, title: "Great Experience!" , rating: 4, content: "Clean, Friendly staff.", shelter: @shelter_1)
    @review_2 = create(:review, title: "Very organized" , rating: 4, content: "Easy to find a pet I love.", shelter: @shelter_2)
    @review_3 = create(:review, title: "The pets are great!", rating: 3, content: "Loved the pet names.", shelter: @shelter_2)
    @review_4 = create(:review, title: "Could have more variety.", rating: 2, content: "Lots of the pets looked very similar.", shelter: @shelter_2)
    @application_1 = Applicant.create!(name: "kwibe merci", address: "3478 MLK", city: "Denver", state: "CO", zip: "34526", phonenumber: "3452690876", description: "I love the pets. They will be my new babies ❤️")
    @application_2 = Applicant.create!(name: "cece kopf", address: "444 sport ave", city: "Salt Lake City", state: "UT", zip: "12345", phonenumber: "3033333333", description: "Loving home. Human  best friend for life.")
    @application_1.pets << [@pet_2]
    @application_2.pets << [@pet_1, @pet_2, @pet_3]
  end
  describe "sees one shelters" do
    it 'displays one shelter' do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_1.address)
      expect(page).to have_content(@shelter_1.state)
      expect(page).to have_content(@shelter_1.city)
      expect(page).to have_content(@shelter_1.zip)
    end

    it 'displays shelter statistics' do
      visit "/shelters/#{@shelter_1.id}"

      expect(page).to have_content("Pet count: #{@shelter_1.pet_count}")
      expect(page).to have_content("Average rating: #{@shelter_1.average_rating}")
      expect(page).to have_content("Applications count: #{@shelter_1.count_applications}")
    end
  end
end
