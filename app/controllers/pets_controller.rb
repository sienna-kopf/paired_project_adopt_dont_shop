class PetsController < ApplicationController
  before_action :find_pet, only: [:show, :update, :edit, :adoptible]
  def index
    @pets = Pet.all
  end

  def show
    @fav_pets = favorites.pet_data
    @pet_application = PetApplication.where(pet_id: params[:pet_id], approval_status: 1).first
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    pet = shelter.pets.create(pet_params)
    if !pet.save
      flash[:errors] = pet.errors.full_messages
      redirect_to "/shelters/#{shelter.id}/pets/new"
    else
      pet.save
      redirect_to "/pets"
    end
  end

  def edit
  end

  def update
    @pet.update(pet_params)
    if !@pet.save
      flash[:errors] = @pet.errors.full_messages
      return redirect_to "/pets/#{@pet.id}/edit"
    end

    redirect_to "/pets/#{@pet.id}"
  end

  def destroy
    pet_applications = PetApplication.where(pet_id: params[:pet_id])

    if pet_applications.any? {|pet_application| pet_application.approval_status == 1}
      flash[:notice] = "Cannot delete: Pet has approved application"
      return redirect_to "/pets/#{params[:pet_id]}"
    end
    pet = Pet.find(params[:pet_id])
    if favorites.pet_data.include?(pet.id)
      favorites.remove_pet(pet.id)
      pet.destroy
    end
    pet.destroy
    redirect_to "/pets"
  end

  def adoptible
    if @pet.status == "adoptible"
      params[:status] = "pending"
    else
      params[:status] = "adoptible"
      @pet.applicants = []
    end
    @pet.update(pet_params)
    redirect_to "/pets/#{@pet.id}"
  end

  private
  def pet_params
    params.permit(:name, :age, :sex, :image, :description, :status)
  end

  def find_pet
    @pet = Pet.find(params[:pet_id])
  end
end
