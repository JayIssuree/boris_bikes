require_relative 'bike_container'

class Van

    include BikeContainer

    def pick_up_broken_bikes(location)
        location.bikes[:broken].reverse.each{ |bike|
            fail "Van at capacity" if full?
            bikes[:broken] << location.bikes[:broken].delete(bike)
        }
    end

    def drop_off_broken_bikes(location)
        bikes[:broken].reverse.each { |bike|
            fail "#{location.class} is at capacity" if location.is_full?
            location.bikes[:broken] << bikes[:broken].delete(bike)
        }
    end

    def pick_up_working_bikes(location)
        location.bikes[:working].reverse.each{ |bike|
            fail "Van at capacity" if full?
            bikes[:working] << location.bikes[:working].delete(bike)
        }
    end

    def drop_off_working_bikes(location)
        bikes[:working].reverse.each { |bike|
            fail "#{location.class} is at capacity" if location.is_full?
            location.bikes[:working] << bikes[:working].delete(bike)
        }
    end

end