require 'rails_helper'

RSpec.describe "user favorites a pet" do
  describe "user can no longer favorite that pet, but can remove it from favorites" do
    before :each do
      @shelter_1 = create(:shelter)
      @shelter_2 = create(:shelter)
      @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
      @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
      @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
      @pet_4 = create(:pet , shelter:@shelter_2 )

      visit "/pets/#{@pet_1.id}"
        click_on "add to favorites"
    end

    it "sees link to remove pet from favorites" do
      visit "/pets/#{@pet_1.id}"

      expect(page).to_not have_link("add to favorites")

      expect(page).to have_link("remove from favorites")
    end

    it "can remove that pet from favorites" do
      visit "/pets/#{@pet_1.id}"

      click_link "remove from favorites"

      expect(current_path).to eq("/pets/#{@pet_1.id}")
      expect(page).to have_content("You have removed #{@pet_1.name} from favorites")

      expect(page).to have_link("add to favorites")
      expect(page).to_not have_link("remove from favorites")

      expect(page).to have_content(favorites: 0)
    end
  end
end
