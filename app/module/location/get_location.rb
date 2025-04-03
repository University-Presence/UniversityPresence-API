require 'httparty'

module Location
  class GetLocation
    include HTTParty
    attr_reader :latitude, :longitude

    def initialize(latitude, longitude)
      @latitude = latitude
      @longitude = longitude
    end

    def get_location
      if latitude.present? && longitude.present?
        response = HTTParty.get("https://nominatim.openstreetmap.org/reverse?lat=#{latitude}&lon=#{longitude}&format=json")
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