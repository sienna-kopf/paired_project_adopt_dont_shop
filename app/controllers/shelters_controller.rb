class SheltersController < ApplicationController
  before_action :find_shelter, only: [:show, :edit, :update, :pets]
  def index
    if params[:sort]
      return @shelters = Shelter.order(:name)
    end
    @shelters = Shelter.all
  end

  def show
  end

  def new
  end

  def create
    shelter = Shelter.create(shelter_params)
    if !shelter.save
      redirect_to "/shelters/new"
    else
      redirect_to "/shelters"
    end
  end

  def edit
  end

  def update
    @shelter.update(shelter_params)
    redirect_to "/shelters/#{@shelter.id}"
  end

  def destroy
    @shelter = Shelter.find(params[:shelter_id])
    @shelter.destroy

    redirect_to "/shelters"
  end

  def pets
    @shelter = Shelter.find(params[:shelter_id])
    @pets = @shelter.pets
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def find_shelter
    @shelter = Shelter.find(params[:shelter_id])
  end
end
