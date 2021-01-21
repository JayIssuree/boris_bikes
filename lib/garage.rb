class Garage

    DEFAULT_CAPACITY = 20

    attr_reader :bikes, :capacity

    def initialize(capacity = DEFAULT_CAPACITY)
        @bikes = { working: [], broken: [] }
        @capacity = capacity
    end
    
    def is_full?
        full?
    end

    private

    def full?
        bikes[:working].length + bikes[:broken].length >= capacity
    end

end
