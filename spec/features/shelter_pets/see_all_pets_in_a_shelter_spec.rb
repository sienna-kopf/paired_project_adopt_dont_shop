require "rails_helper"

RSpec.describe '', type: :feature do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet , shelter:@shelter_2 )
  end
  it 'should all pets in shelter' do
    visit "/shelters/#{@shelter_1.id}/pets"
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_1.age)
    expect(page).to have_content(@pet_1.sex)
    expect(page).to have_content(@pet_3.name)
    expect(page).to have_content(@pet_3.age)
    expect(page).to have_content(@pet_3.sex)
    expect(page).to have_content("2")
  end
end
