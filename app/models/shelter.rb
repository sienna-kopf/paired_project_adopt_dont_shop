class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, dependent: :delete_all

  def pet_count
    self.pets.count
  end
end
