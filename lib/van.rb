class Van

    DEFAULT_CAPACITY = 20

    attr_reader :bikes, :capacity

    def initialize(capacity = DEFAULT_CAPACITY)
        @capacity = capacity
        @bikes = { broken: [], working: [] }
    end

    def pick_up_broken_bikes(location)
        location.select_broken_bikes.reverse_each{ |bike|
            fail "Van at capacity" if full?
            bikes[:broken] << bike
            location.bikes[:broken].delete(bike)
        }
    end

    def full?
        bikes[:working].length + bikes[:broken].length >= capacity
    end

end