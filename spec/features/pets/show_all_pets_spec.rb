require "rails_helper"

RSpec.describe "show all pets" do
  before :each do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet , shelter:@shelter_2 )
  end

  it 'shows all pets' do
    visit "/pets"

    within "div#pet_#{@pet_1.id}" do
      expect(page).to have_link(@pet_1.shelter.name)
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_1.age)
      expect(page).to have_content(@pet_1.sex)
    end

    within "div#pet_#{@pet_2.id}" do
      expect(page).to have_link(@pet_2.shelter.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_2.age)
      expect(page).to have_content(@pet_2.sex)
    end
  end
end
