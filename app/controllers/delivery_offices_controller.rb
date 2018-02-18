class DeliveryOfficesController < ApplicationController
  before_action :set_delivery_office, only: [:show, :edit, :update, :destroy]

  include PostcodeHelper

  def index
    @delivery_offices = DeliveryOffice.all
  end

  def search
    if valid_postcode?
      @delivery_offices = DeliveryOffice.near(params[:postcode], radius)
    else
      @errors = validator.errors
    end
  rescue => e
    Rails.logger.error(e)
    @errors = t('delivery_office.service_not_available') + ": #{e.message}"
  end

  def show
  end

  def new
    @delivery_office = DeliveryOffice.new
  end

  def edit
  end

  def create
    @delivery_office = DeliveryOffice.new(delivery_office_params)

    respond_to do |format|
      if @delivery_office.save
        format.html { redirect_to @delivery_office, notice: t('delivery_office.created') }
        format.json { render :show, status: :created, location: @delivery_office }
      else
        format.html { render :new }
        format.json { render json: @delivery_office.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @delivery_office.update(delivery_office_params)
        format.html { redirect_to @delivery_office, notice: t('delivery_office.updated') }
        format.json { render :show, status: :ok, location: @delivery_office }
      else
        format.html { render :edit }
        format.json { render json: @delivery_office.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @delivery_office.destroy
    respond_to do |format|
      format.html { redirect_to delivery_offices_url, notice: t('delivery_office.deleted') }
      format.json { head :no_content }
    end
  end

  private

  def set_delivery_office
    @delivery_office = DeliveryOffice.find(params[:id])
  end

  def delivery_office_params
    params.require(:delivery_office).permit(:name, :address, :postcode, :latitude, :longitude)
  end

  def search_params
    params.permit(:postcode, :radius)
  end
end
