# fraday connection class
class Connection
  class ApiError < Error; end

  BASE_URL = ENV.fetch('POSTCODE_LOOKUP_API_URL').freeze

  def api_response(method, endpoint, params = {})
    params = params.to_json unless method == :get
    response = adapter.send(method, endpoint, params)
    response.body
  rescue Faraday::Error => e
    Rails.logger.error(e.message)
    { errors: e.message }
  end

  private

  def adapter
    @adapter ||= Faraday.new(url: BASE_URL) do |conn|
      conn.response :json, content_type: 'application/json'
      conn.adapter :net_http
    end
  end
end
