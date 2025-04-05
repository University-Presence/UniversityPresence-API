require 'httparty'

module Location
  class GetLocation
    include HTTParty
    attr_reader :location

    def initialize(location)
      @location = location
    end

    def get_location
      if location.present?
        serch_location = URI.encode_www_form_component(location)
        response = HTTParty.get("https://nominatim.openstreetmap.org/search?q=#{serch_location}&format=json&limit=1&addressdetails=")
        JSON.parse(response.body)
      else
        raise ArgumentError, 'Latitude and longitude are required'
      end
    end

    def perform
      get_location
    rescue ArgumentError => e
      Rails.logger.error("Error getting location: #{e.message}")
      nil
    end
  end
end