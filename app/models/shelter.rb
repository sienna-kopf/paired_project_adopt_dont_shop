class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, dependent: :delete_all
  has_many :reviews, dependent: :delete_all

  def pet_count
    self.pets.count
  end

  def average_rating
    if self.reviews.size <= 0
        return 0
    end
    self.reviews.average(:rating)
  end

  def count_applications
    self.pets.where(status: 'pending').count
  end
end
