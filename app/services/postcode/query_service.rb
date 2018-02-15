module Postcode
  # this class uses for postcode.io endpoints
  class QueryService
    def postcode_lookup(postcode)
      connection.api_response(
        :get,
        postcode_lookup_endpoint(postcode)
      ).deep_symbolize_keys
    end

    private

    def connection
      @connection ||= Connection.new
    end

    def sanitize(postcode)
      postcode.to_s.strip.delete(' ')
    end

    def postcode_lookup_endpoint(postcode)
      "/postcodes/#{sanitize(postcode)}"
    end
  end
end
