class SheltersController < ApplicationController
  before_action :find_shelter, only: [:show, :edit, :update, :pets]
  def index
    if params[:sort]
      return @shelters = Shelter.order(:name)
    end
    @shelters = Shelter.all
  end

  def show
    @reviews = @shelter.reviews.order(updated_at: :desc)
  end

  def new
  end

  def create
    shelter = Shelter.create(shelter_params)
    if !shelter.save
      flash[:errors] = shelter.errors.full_messages
      redirect_to "/shelters/new"
    else
      redirect_to "/shelters"
    end
  end

  def edit
  end

  def update
    @shelter.update(shelter_params)
    if !@shelter.save
      flash[:errors] = @shelter.errors.full_messages
      return redirect_to "/shelters/#{@shelter.id}/edit"
    end
    redirect_to "/shelters/#{@shelter.id}"
  end

  def destroy
    shelter = Shelter.find(params[:shelter_id])
    if shelter.pets.any?{|pet| pet.status == "pending"}
      flash[:notice] = "Cannot delete: Shelter has pending application"
      return redirect_to "/shelters/#{shelter.id}"
    end
    shelter.destroy

    redirect_to "/shelters"
  end

  def pets
    @shelter = Shelter.find(params[:shelter_id])
    @pets = @shelter.pets ## can call in view
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end

  def find_shelter
    @shelter = Shelter.find(params[:shelter_id])
  end
end
