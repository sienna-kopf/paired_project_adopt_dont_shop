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
end
