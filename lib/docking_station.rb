require_relative 'bike'

class DockingStation

    DEFAULT_CAPACITY = 20
    attr_reader :bikes, :capacity

    def initialize(capacity = DEFAULT_CAPACITY)
        @capacity = capacity
        @bikes = []
    end

    def release_bike
        fail "No bikes available" if empty?
        @bikes.pop
    end

    def dock(bike)
        fail "Docking station at capacity" if full?
        @bikes << bike
        bike
    end

    private

    def full?
        @bikes.length >= capacity
    end

    def empty?
        @bikes.empty?
    end

end