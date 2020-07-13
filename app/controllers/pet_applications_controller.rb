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
        add_pet(pet)
      end
      return redirect_to "/pets"
    end
    pet = Pet.find(params[:pet_id])

    if pet.status == 'pending'
      flash[:error] = "No more applications can be approved for #{pet.name} at this time"
      return redirect_to "/applications/#{applicant.id}"
    end
    add_pet(pet)

    redirect_to "/pets/#{pet.id}"
  end

  private
  def pet_params
    params.permit(:status)
  end

  def add_pet(p)
    p.update(pet_params)
    p.applicants.delete(applicant)
    p.applicants << applicant
  end
end
