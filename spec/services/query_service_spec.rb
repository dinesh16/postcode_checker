require 'rails_helper'

RSpec.describe Postcode::QueryService, type: :model do
  it 'searching for given postcode', :vcr do
    response = Postcode::QueryService.new.postcode_lookup('WD18 6FU')

    expect(response[:status]).to eq 200
    expect(response[:result]).to include(:longitude, :latitude, :postcode)
  end

  it 'searching for given wrong postcode', :vcr do
    response = Postcode::QueryService.new.postcode_lookup('WD19WFU')

    expect(response[:status]).to eq 404
    expect(response[:error]).to eq('Invalid postcode')
  end

  it 'searching for given invalid postcode', :vcr do
    response = Postcode::QueryService.new.postcode_lookup('WD186FY')

    expect(response[:status]).to eq 404
    expect(response[:error]).to eq('Postcode not found')
  end
end
