
class FavoritesController <  ApplicationController
  def create
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet)
    flash[:notice] =  "You have added #{pet.name} to favorites"
    redirect_to "/pets/#{pet.id}"
  end

  def destroy
    pet = Pet.find(params[:pet_id])
    favorites.pet_data.delete(pet)
    flash[:notice] =  "You have removed #{pet.name} from favorites"
    redirect_to "/pets/#{pet.id}"
  end
end
