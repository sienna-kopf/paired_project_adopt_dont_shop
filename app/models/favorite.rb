
class Favorite
  attr_reader :pet_data
  def initialize(pet_data)
    @pet_data = pet_data
  end

  def count
    @pet_data.count
  end

  def add_pet(pet)
    @pet_data << pet.id
  end

  def remove_pet(pet)
    @pet_data.delete(pet)
  end
end
