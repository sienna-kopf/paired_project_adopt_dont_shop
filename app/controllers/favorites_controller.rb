
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
  end
end
