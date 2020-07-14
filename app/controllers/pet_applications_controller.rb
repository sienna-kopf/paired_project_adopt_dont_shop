class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:pet_id])
    @applicants = @pet.applicants
  end

  def update
    pet_application = PetApplication.where(pet_id: params[:pet_id],applicant_id: params[:applicant])

    pet = Pet.find(params[:pet_id])
    if PetApplication.where(pet_id: pet.id).pluck(:approval_status).include?(1)
      flash[:error] = "No more applications can be approved for #{pet.name} at this time"
      return redirect_to "/applications/#{params[:applicant]}"
    end
    pet_application.update(approval_status: 1)

    params[:status] = "pending"
    pet.update(pet_params)

    redirect_to "/pets/#{pet.id}"
  end

  def unapprove
    pet_application = PetApplication.where(pet_id: params[:pet_id],applicant_id: params[:applicant])
    pet = Pet.find(params[:pet_id].to_i)

    pet_application.update(approval_status: 0)
    pet.update(status: "adoptible")

    redirect_to "/applications/#{params[:applicant]}"
  end

  def approve_all
    applicant = Applicant.find(params[:applicant])
    applicant.pets.each do |pet|
      pet_application = PetApplication.where(pet_id: pet.id,applicant_id: params[:applicant])
      if PetApplication.where(pet_id: pet.id).pluck(:approval_status).include?(0)
        pet.update(status: "pending")
        pet_application.update(approval_status: 1)
      end
    end
    redirect_to "/applications/#{params[:applicant]}"
  end

  private
  def pet_params
    params.permit(:status)
  end
end
