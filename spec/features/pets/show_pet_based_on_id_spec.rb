require "rails_helper"

RSpec.describe 'show a pet' do
  before :each do
    @shelter_1 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_1)
  end

  it 'display a pet' do
    visit "/pets/#{@pet_1.id}"

    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.age)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content(@pet_1.description)
    expect(page).to have_content(@pet_1.status)
  end
end
