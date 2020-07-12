class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:pet_id])
    @applicants = @pet.applicants
  end

  def update
    pet = Pet.find(params[:pet_id])
    params[:status] = "pending"
    pet.update(pet_params)
    pet.applicants = []
    pet.applicants << Applicant.find(params[:applicant])

    redirect_to "/pets/#{pet.id}"
  end

  private
  def pet_params
    params.permit(:status)
  end
end