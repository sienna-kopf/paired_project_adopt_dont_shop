class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:pet_id])
    @applicants = @pet.applicants
  end

  def update
    pet_application = PetApplication.where(pet_id: params[:pet_id],applicant_id: params[:applicant])
    pet_application.update(approval_status: 1)
    pet = Pet.find(params[:pet_id])
    params[:status] = "pending"
    pet.update(pet_params)
    # binding.pry
    # applicant = Applicant.find(params[:applicant])
    # if pet.status == 'adoptible' # "adoptable"
    #   params[:status] = "pending"
    #   if params[:approve_all]
    #     applicant.pets.each do |pet|
    #       add_pet(pet, applicant)
    #     end
    #     return redirect_to "/pets"
    #   end
    #   add_pet(pet, applicant)
    #
    #   redirect_to "/pets/#{pet.id}"
    # else
    #   params[:status] = "adoptible"
    #   # flash[:error] = "No more applications can be approved for #{pet.name} at this time"
    #   # return redirect_to "/applications/#{applicant.id}"
    #   add_pet(pet, applicant)

      redirect_to "/applications/#{params[:applicant]}"
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
