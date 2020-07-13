require "rails_helper"

RSpec.describe "revoke approved application", type: :feature do
  before :all do
    @shelter_1 = create(:shelter)
    @shelter_2 = create(:shelter)
    @pet_1 = create(:pet, name: "persy", age: 8, sex: "male", shelter: @shelter_1)
    @pet_2 = create(:pet, name: "piper", age: 12, sex: "female", shelter: @shelter_2)
    @pet_3 = create(:pet, name: "holie", age: 4, sex: "female", shelter: @shelter_1)
    @pet_4 = create(:pet , shelter:@shelter_2 )
    @application = create(:applicant)
    @application_2 = create(:applicant)
    @application.pets << [@pet_2, @pet_1]
    @application_2.pets << [@pet_2, @pet_3, @pet_1]
  end

  it 'can revoke an approved application' do
    visit "/applications/#{@application.id}"

    within "div#pet_#{@pet_1.id}" do
      click_on 'Approve'
    end

    visit "/applications/#{@application.id}"

    within("footer#approval-status-#{@pet_1.id}") do
      expect(page).to_not have_link('Approve')
      click_link "Unapprove"
    end

    expect(current_path).to eq("/applications/#{@application.id}")

    within("footer#approval-status-#{@pet_1.id}") do
      expect(page).to have_link('Approve')
      expect(page).to_not have_link('Unapprove')
    end

    visit "/pets/#{@pet_1.id}"

    expect(page).to have_content("adoptible")
    expect(page).to have_content("persy")
    expect(page).to_not have_content("on hold for #{@application.name}")
  end
end
