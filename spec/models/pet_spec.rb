require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'validations' do
    it{should validate_presence_of :name}
    it{should validate_presence_of :age}
    it{should validate_presence_of :sex}
    it{should validate_presence_of :image}
    it{should validate_presence_of :description}
    it{should validate_presence_of :status}
  end

  describe 'relationships' do
    it{should belong_to :shelter}
    it{should have_many :pet_applications}
    it { should have_many(:applicants).through(:pet_applications)}
  end

  describe 'methods' do

    it '#count_applicants' do
      @shelter_1 = create(:shelter)
      @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
      @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_1)
      @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
      @application_1 = Applicant.create!(name: "kwibe merci", address: "3478 MLK", city: "Denver", state: "CO", zip: "34526", phonenumber: "3452690876", description: "I love the pets. They will be my new babies ❤️")
      @application_2 = Applicant.create!(name: "cece kopf", address: "444 sport ave", city: "Salt Lake City", state: "UT", zip: "12345", phonenumber: "3033333333", description: "Loving home. Human  best friend for life.")
      @application_1.pets << [@pet_2]
      @application_2.pets << [@pet_1, @pet_2, @pet_3]

      expect(@pet_1.count_applicants).to eq(1)
      expect(@pet_2.count_applicants).to eq(2)
    end
  end
end
