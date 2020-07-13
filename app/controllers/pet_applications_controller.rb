class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:pet_id])
    @applicants = @pet.applicants
  end

  def update
    applicant = Applicant.find(params[:applicant])
    pet = Pet.find(params[:pet_id])
    if pet.status == 'adoptible' # "adoptable"
      params[:status] = "pending"
      if params[:approve_all]
        applicant.pets.each do |pet|
          add_pet(pet, applicant)
        end
        return redirect_to "/pets"
      end
      add_pet(pet, applicant)

      redirect_to "/pets/#{pet.id}"
    else
      params[:status] = "adoptible"
      # flash[:error] = "No more applications can be approved for #{pet.name} at this time"
      # return redirect_to "/applications/#{applicant.id}"
      add_pet(pet, applicant)

      redirect_to "/applications/#{applicant.id}"
    end
  end

  private
  def pet_params
    params.permit(:status)
  end

  def add_pet(pet,applicant)
    pet.update(pet_params)
    pet.applicants.delete(applicant)
    pet.applicants << applicant
  end
end
