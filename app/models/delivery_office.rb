class DeliveryOffice < ApplicationRecord
  geocoded_by :postcode
  after_validation :geocode

  validates :name, :postcode, presence: true
  validate :validate_postcode

  def validate_postcode
    validator.valid_postcode?(postcode)
    errors.add(:postcode, ": #{validator.errors}") if validator.errors.present?
  end

  def validator
    @validator ||= PostcodeValidator.new
  end
end
