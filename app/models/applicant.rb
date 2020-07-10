class Applicant < ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :phonenumber, :description
  has_many :pet_applications
  has_many :pets, through: :pet_applications
end
