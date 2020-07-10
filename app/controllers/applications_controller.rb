class ApplicationsController < ApplicationController
  def new
  end

  def create
    application = Applicant.create(application_params)
    if !application.save
      flash[:errors] = application.errors.full_messages
      return redirect_to "/applications/new"
    end
    flash[:notice] = "Application has gone through"
    favorites.remove_all
    redirect_to '/favorites'
  end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phonenumber, :description, :pet_ids)
  end
end
