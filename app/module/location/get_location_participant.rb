require 'httparty'

module Location
  class GetLocationParticipant < GetLocation
    EARTH_RADIUS = 6371.0
    ALLOWED_RADIUS = 100

    def initialize(latitude, longitude, event_latitude, event_longitude)
      @event_latitude = event_latitude
      @event_longitucde = event_longitude
      super(latitude, longitude)
    end

    def distance(lat1, lon1, lat2, lon2)
      lat1_rad, lon1_rad = [lat1, lon1].map { |d| to_radians(d) }
      lat2_rad, lon2_rad = [lat2, lon2].map { |d| to_radians(d) }
  
      dlat = lat2_rad - lat1_rad
      dlon = lon2_rad - lon1_rad
  
      a = Math.sin(dlat / 2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon / 2)**2
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
  
      (EARTH_RADIUS * c) * 1000
    end
  
    def to_radians(degrees)
      degrees * Math::PI / 180
    end
  end
end