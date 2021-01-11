require_relative 'bike'

class DockingStation

    DEFAULT_CAPACITY = 20
    attr_reader :bikes, :capacity

    def initialize(capacity = DEFAULT_CAPACITY)
        @capacity = capacity
        @bikes = []
    end

    def release_bike
        fail "No bikes available" if @bikes.empty?
        @bikes.pop
    end

    def dock(bike)
        fail "Docking station at capacity" if @bikes.length >= capacity
        @bikes << bike
        bike
    end

end