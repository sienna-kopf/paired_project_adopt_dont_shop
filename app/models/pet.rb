class Pet < ApplicationRecord
  validates_presence_of :name, :age, :sex, :image, :description, :status
  belongs_to :shelter
  enum sex: {male: "male", female:"female"}
  has_many :pet_applications, dependent: :delete_all
  has_many :applicants, through: :pet_applications

  def count_applicants
    self.applicants.count
  end
end
