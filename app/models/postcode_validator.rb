class PostcodeValidator
  attr_accessor :errors
  def sanitize(postcode)
    postcode.to_s.strip.delete(' ')
  end

  def valid_postcode?(postcode)
    result = Postcode::QueryService.new.postcode_lookup(sanitize(postcode))
    if result.present? && result[:error].present?
      @errors = result[:error]
      false
    else
      true
    end
  end
end
