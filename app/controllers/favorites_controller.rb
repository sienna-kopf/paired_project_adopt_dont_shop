
class FavoritesController <  ApplicationController
  def create
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet)
    flash[:notice] =  "You have added #{pet.name} to favorites"
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorites.remove_pet(pet.id)
    flash[:notice] = "You have removed #{pet.name} from favorites"
    redirect_to "/pets/#{pet.id}"
  end

  def index
    @pets = favorites.find_pets.reverse
    @application_pets = PetApplication.pluck(:pet_id).uniq.map {|id| Pet.find(id)}
  end

  def remove
    pet = Pet.find(params[:pet_id])
    favorites.remove_pet(pet.id)
    flash[:notice] = "You have removed #{pet.name} from favorites"
    redirect_to "/favorites"
  end

  def remove_all
    favorites.remove_all
    flash[:notice] = "You have removed all pets from favorites"
    redirect_to "/favorites"
  end
end
