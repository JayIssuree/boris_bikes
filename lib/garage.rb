class Garage

    attr_reader :bikes

    def initialize
        @bikes = { working: [], broken: [] }
    end

    def select_working_bikes
        bikes[:working]
    end

    def select_broken_bikes
        bikes[:broken]
    end

end
