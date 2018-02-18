module PostcodeHelper
  def validator
    @validator ||= PostcodeValidator.new
  end

  def valid_postcode?
    validator.valid_postcode?(search_params[:postcode])
  end

  def radius
    search_params[:radius].to_i > 0 ? search_params[:radius] : default_redius
  end

  def default_redius
    50
  end
end
