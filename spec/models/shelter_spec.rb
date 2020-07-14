require 'rails_helper'

RSpec.describe Shelter, type: :model do
  describe "validations" do
    it{should validate_presence_of :name}
    it{should validate_presence_of :address}
    it{should validate_presence_of :city}
    it{should validate_presence_of :state}
    it{should validate_presence_of :zip}
  end

  describe 'relationships' do
    it{should have_many :pets}
    it{should have_many :reviews}
  end

  describe 'methods' do
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
    it 'count_pets' do
      expect(@shelter_1.count_pets).to eq(1)
      expect(@shelter_2.count_pets).to eq(3)
    end

    xit 'average_rating' do
      expect(@shelter_1.average_rating).to eq(4)
      expect(@shelter_2.average_rating).to eq(3)
    end

    xit 'count_applications' do
      expect(@shelter_1.count_applications).to eq(1)
      expect(@shelter_2.count_applications).to eq(3)
    end
  end
end
