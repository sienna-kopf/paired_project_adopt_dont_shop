class PetApplicationsController < ApplicationController
  def index
    @pet = Pet.find(params[:pet_id])
    @applicants = PetApplication.pluck(:applicant_id).uniq.map {|applicant_id| Applicant.find(applicant_id)}
  end
end
