class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:pet_id])
    @applicants = @pet.applicants
  end

  def update
    applicant = Applicant.find(params[:applicant])
    params[:status] = "pending"
    if params[:approve_all]
      applicant.pets.each do |pet|
        pet.update(pet_params)
        pet.applicants.delete(applicant)
        pet.applicants << applicant
      end
      return redirect_to "/pets"
    end
    pet = Pet.find(params[:pet_id])
    pet.update(pet_params)
    pet.applicants.delete(applicant)
    pet.applicants << applicant

    redirect_to "/pets/#{pet.id}"
  end

  private
  def pet_params
    params.permit(:status)
  end
end
