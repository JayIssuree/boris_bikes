class Van

    DEFAULT_CAPACITY = 20

    attr_reader :bikes, :capacity

    def initialize(capacity = DEFAULT_CAPACITY)
        @capacity = capacity
        @bikes = { broken: [], working: [] }
    end

    def pick_up_broken_bikes(location)
        location.select_broken_bikes.reverse.each{ |bike|
            fail "Van at capacity" if full?
            bikes[:broken] << location.bikes[:broken].delete(bike)
        }
    end

    def drop_off_broken_bikes(location)
        bikes[:broken].reverse.each { |bike|
            # fail if location.is_full?
            location.bikes[:broken] << bikes[:broken].delete(bike)
        }
    end

    def pick_up_working_bikes(location)
        location.select_working_bikes.reverse.each{ |bike|
            fail "Van at capacity" if full?
            bikes[:working] << location.bikes[:working].delete(bike)
        }
    end

    def drop_off_working_bikes(location)
        bikes[:working].reverse.each { |bike|
            # fail if location.is_full?
            location.bikes[:working] << bikes[:working].delete(bike)
        }
    end

    private

    def full?
        bikes[:working].length + bikes[:broken].length >= capacity
    end

end