class Review < ApplicationRecord
  validates_presence_of :title, :rating, :content
end
