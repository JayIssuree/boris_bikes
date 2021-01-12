require_relative 'bike'

class DockingStation

    DEFAULT_CAPACITY = 20
    attr_reader :bikes, :capacity

    def initialize(capacity = DEFAULT_CAPACITY)
        @capacity = capacity
        @bikes = []
    end

    def release_bike
        fail "No working bikes available" unless available_bike?
        select_first_working_bike
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

    def available_bike?
        number_of_available_bikes = 0
        bikes.each { |bike|
            number_of_available_bikes += 1 if bike.working?
        }
        number_of_available_bikes > 0
    end

    def select_first_working_bike
        bikes.delete(
            bikes.select {|bike|
                bike.working?
            }.pop
        )
    end

end