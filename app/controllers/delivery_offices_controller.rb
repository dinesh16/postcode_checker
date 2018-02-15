class DeliveryOfficesController < ApplicationController
  before_action :set_delivery_office, only: [:show, :edit, :update, :destroy]
  # before_action :validate_search_params, only: [:search]

  # GET /delivery_offices
  # GET /delivery_offices.json
  def index
    @delivery_offices = DeliveryOffice.all
  end

  # GET /delivery_offices/search
  def search
    # return if params[:postcode].blank?
    if valid_postcode?
      @delivery_offices = DeliveryOffice.near(params[:postcode], radius)
    else
      @errors = validator.errors
    end
  end

  # GET /delivery_offices/1
  # GET /delivery_offices/1.json
  def show
  end

  # GET /delivery_offices/new
  def new
    @delivery_office = DeliveryOffice.new
  end

  # GET /delivery_offices/1/edit
  def edit
  end

  # POST /delivery_offices
  # POST /delivery_offices.json
  def create
    @delivery_office = DeliveryOffice.new(delivery_office_params)

    respond_to do |format|
      if @delivery_office.save
        format.html { redirect_to @delivery_office, notice: 'Delivery office was successfully created.' }
        format.json { render :show, status: :created, location: @delivery_office }
      else
        format.html { render :new }
        format.json { render json: @delivery_office.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /delivery_offices/1
  # PATCH/PUT /delivery_offices/1.json
  def update
    respond_to do |format|
      if @delivery_office.update(delivery_office_params)
        format.html { redirect_to @delivery_office, notice: 'Delivery office was successfully updated.' }
        format.json { render :show, status: :ok, location: @delivery_office }
      else
        format.html { render :edit }
        format.json { render json: @delivery_office.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /delivery_offices/1
  # DELETE /delivery_offices/1.json
  def destroy
    @delivery_office.destroy
    respond_to do |format|
      format.html { redirect_to delivery_offices_url, notice: 'Delivery office was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_delivery_office
    @delivery_office = DeliveryOffice.find(params[:id])
  end

  # Never trust params from the internet, only allow the white list through.
  def delivery_office_params
    params.require(:delivery_office).permit(:name, :address, :postcode, :latitude, :longitude)
  end

  def search_params
    params.permit(:postcode, :radius)
  end

  def radius
    search_params[:radius].present? ? search_params[:radius] : 50
  end

  def validator
    @validator ||= PostcodeValidator.new
  end

  def valid_postcode?
    validator.valid_postcode?(search_params[:postcode])
  end
end
