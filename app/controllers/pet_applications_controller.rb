class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:pet_id])
    @applicants = @pet.applicants
  end

  def update
    pet = Pet.find(params[:pet_id])
    applicant = Applicant.find(params[:applicant])
    if pet.status == 'adoptible'
      params[:status] = "pending"
      if params[:approve_all]
        applicant.pets.each do |pet|
          pet.update(pet_params)
          pet.applicants.delete(applicant)
          pet.applicants << applicant
        end
        return redirect_to "/pets"
      end
      pet.update(pet_params)
      pet.applicants.delete(applicant)
      pet.applicants << applicant

      redirect_to "/pets/#{pet.id}"
    else
      params[:status] = "adoptible"
      pet.update(pet_params)
      pet.applicants.delete(applicant)
      pet.applicants << applicant

      redirect_to "/applications/#{applicant.id}"
    end
  end

  private
  def pet_params
    params.permit(:status)
  end
end
