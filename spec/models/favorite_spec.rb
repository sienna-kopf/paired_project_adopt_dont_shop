
require "rails_helper"

RSpec.describe Favorite do
  before :all do
    @favorite = Favorite.new(Array.new(0))
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
  end

  it 'has can count pets' do
    expect(@favorite.count).to eq(0)
  end

  it 'can add to favorites' do
    @favorite.add_pet(@pet_1)

    expect(@favorite.count).to eq(1)
    expect(@favorite.pet_data).to eq([@pet_1.id])

    @favorite.add_pet(@pet_2)
    expect(@favorite.count).to eq(2)
    expect(@favorite.pet_data).to eq([@pet_1.id, @pet_2.id])
  end
end