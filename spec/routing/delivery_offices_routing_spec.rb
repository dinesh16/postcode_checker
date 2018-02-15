require 'rails_helper'

RSpec.describe DeliveryOfficesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/delivery_offices').to route_to('delivery_offices#index')
    end

    it 'routes to #new' do
      expect(get: '/delivery_offices/new').to route_to('delivery_offices#new')
    end

    it 'routes to #show' do
      expect(get: '/delivery_offices/1').to route_to('delivery_offices#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/delivery_offices/1/edit').to route_to('delivery_offices#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/delivery_offices').to route_to('delivery_offices#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/delivery_offices/1').to route_to('delivery_offices#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/delivery_offices/1').to route_to('delivery_offices#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/delivery_offices/1').to route_to('delivery_offices#destroy', id: '1')
    end
  end
end
