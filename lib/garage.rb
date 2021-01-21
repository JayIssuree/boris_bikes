class Garage

    DEFAULT_CAPACITY = 20

    attr_reader :bikes, :capacity

    def initialize(capacity = DEFAULT_CAPACITY)
        @bikes = { working: [], broken: [] }
        @capacity = capacity
    end

end
