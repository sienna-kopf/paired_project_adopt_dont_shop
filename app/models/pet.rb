class Pet < ApplicationRecord
  validates_presence_of :name, :age, :sex, :image, :description, :status
  belongs_to :shelter
  enum sex: {male: "male", female:"female"}
  has_many :pet_applications
  has_many :applicants, through: :pet_applications
end
