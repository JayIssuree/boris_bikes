require_relative 'bike_container'

class Garage

    include BikeContainer

    def fix_broken_bikes
        bikes[:broken].reverse.each { |bike| 
            bike.fix
            bikes[:working] << bikes[:broken].delete(bike)
        }
    end

end
