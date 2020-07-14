class Shelter < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip
  has_many :pets, dependent: :delete_all
  has_many :reviews, dependent: :delete_all

  def pet_count
    self.pets.count
  end

  def average_rating
    reviews.sum do |review|
      review.rating
    end / reviews.count
  end
end
