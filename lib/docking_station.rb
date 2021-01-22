require_relative 'bike'
require_relative 'van'
require_relative 'garage'
require_relative 'bike_container'

class DockingStation

    include BikeContainer

    def release_bike
        fail "No working bikes available" unless available_bike?
        bikes[:working].pop
    end

    def dock(bike)
        fail "Docking station at capacity" if full?
        bike.working? == true ? bikes[:working] << bike : bikes[:broken] << bike
        bike
    end

    private

    def available_bike?
        !bikes[:working].empty?
    end

end