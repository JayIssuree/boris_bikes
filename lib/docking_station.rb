require_relative 'bike'
require_relative 'van'

class DockingStation

    DEFAULT_CAPACITY = 20
    attr_reader :bikes, :capacity

    def initialize(capacity = DEFAULT_CAPACITY)
        @capacity = capacity
        @bikes = { working: [], broken: [] }
    end

    def release_bike
        fail "No working bikes available" unless available_bike?
        select_working_bikes.pop
    end

    def dock(bike)
        fail "Docking station at capacity" if full?
        bike.working? == true ? bikes[:working] << bike : bikes[:broken] << bike
        bike
    end

    private

    def full?
        bikes[:working].length + bikes[:broken].length >= capacity
    end

    def available_bike?
        !bikes[:working].empty?
    end

    def select_working_bikes
        bikes[:working]
    end

    def select_broken_bikes
        bikes[:broken]
    end

end