class PetsController < ApplicationController
  before_action :find_pet, only: [:show, :update,:edit, :adoptible]
  def index
    @pets = Pet.all
  end

  def show
    @fav_pets = favorites.pet_data
    approved_applicant_id = PetApplication.where(pet_id: @pet.id).pluck(:applicant_id).last
    if !approved_applicant_id.nil?
      @approved_applicant = Applicant.find(approved_applicant_id)
    end
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    shelter = Shelter.find(params[:shelter_id])
    @pet = shelter.pets.create(pet_params)
    redirect_to "/pets"
  end

  def edit
  end

  def update
    @pet.update(pet_params)

    redirect_to "/pets/#{@pet.id}"
  end

  def destroy
    Pet.destroy(params[:pet_id])
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
