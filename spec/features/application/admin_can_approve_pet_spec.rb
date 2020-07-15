require "rails_helper"

RSpec.describe "approve pet", type: :feature do
  before :each do
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

  it 'can see information about an application' do
    visit "/applications/#{@application.id}"
    within "div#pet_#{@pet_1.id}" do
      click_on 'Approve'
    end
    expect(current_path).to eq("/pets/#{@pet_1.id}")
    expect(page).to have_content("pending")
    expect(page).to have_content("persy")
    expect(page).to have_content("on hold for #{@application.name}")

    visit "/applications/#{@application.id}"
    within "div#pet_#{@pet_2.id}" do
      click_on "Approve"
    end
    expect(current_path).to eq("/pets/#{@pet_2.id}")
    expect(page).to have_content("pending")
    expect(page).to have_content("piper")
    expect(page).to have_content("on hold for #{@application.name}")
  end

  it 'can update all' do
    visit "/applications/#{@application.id}"

    expect(page).to have_link("approve all")

    click_on "approve all"

    visit "/pets/#{@pet_2.id}"
    expect(page).to have_content("pending")
    expect(page).to have_content("on hold for #{@application.name}")

    visit "/pets/#{@pet_1.id}"
    expect(page).to have_content("pending")
    expect(page).to have_content("on hold for #{@application.name}")

  end
end
