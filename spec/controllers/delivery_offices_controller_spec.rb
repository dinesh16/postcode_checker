require 'rails_helper'

RSpec.describe DeliveryOfficesController, type: :controller do
  let!(:delivery_office) { FactoryBot.create(:delivery_office) }
  let(:valid_attributes) {
    {
      name: Faker::Company.name,
      addrss: Faker::Address.street_name,
      postcode: 'UB6 9QL'
    }
  }
  let!(:invalid_postcode) { 'WW88WW99' }
  let(:invalid_attributes) {
    valid_attributes.merge!(postcode: invalid_postcode)
  }

  describe 'GET #index', :vcr do
    it 'returns a success response' do
      get :index
      expect(response).to be_success
    end
  end

  describe 'GET #search' do
    context 'with valid params' do
      it 'returns a success response', :vcr do
        get :search, params: { postcode: 'WD18 6FU', radius: 20 }

        expect(response).to be_success
        expect(assigns(:delivery_offices).size).to eq(1)
      end
    end

    context 'with invalid params' do
      it 'returns a success response', :vcr do
        get :search, params: { postcode: 'WD1896FU', radius: 20 }

        expect(response).to be_success
        expect(assigns(:errors)).to be_present
      end
    end
  end

  describe 'GET #show' do
    it 'returns a success response', :vcr do
      get :show, params: { id: delivery_office.to_param }
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a success response', :vcr do
      get :new
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    it 'returns a success response', :vcr do
      get :edit, params: { id: delivery_office.to_param }
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new DeliveryOffice', :vcr do
        expect {
          post :create, params: { delivery_office: valid_attributes }
        }.to change(DeliveryOffice, :count).by(1)
      end

      it 'redirects to the created delivery_office', :vcr do
        post :create, params: { delivery_office: valid_attributes }
        expect(response).to redirect_to(DeliveryOffice.last)
      end
    end

    context 'with invalid params' do
      it 'returns a success response', :vcr do
        post :create, params: { delivery_office: invalid_attributes }
        expect(response).to be_success

        expect(assigns(:delivery_office).errors).not_to be_empty
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_postcode) { 'WD18 6FU' }
      let(:new_attributes) {
        valid_attributes.merge!(postcode: new_postcode)
      }

      it 'updates the requested delivery_office', :vcr do
        put :update, params: {
          id: delivery_office.to_param,
          delivery_office: new_attributes
        }
        delivery_office.reload
        expect(response).to redirect_to(delivery_office)
        expect(delivery_office.postcode).to eq(new_postcode)
      end
    end

    context 'with invalid params' do
      it 'returns a success response', :vcr do
        put :update, params: {
          id: delivery_office.to_param,
          delivery_office: invalid_attributes
        }
        expect(response).to be_success
        expect(assigns(:delivery_office).errors).not_to be_empty
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested delivery_office', :vcr do
      expect {
        delete :destroy, params: { id: delivery_office.to_param }
      }.to change(DeliveryOffice, :count).by(-1)
      expect(response).to redirect_to(delivery_offices_url)
    end
  end
end
