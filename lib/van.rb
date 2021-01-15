class Van

    attr_reader :bikes

    def initialize
        @bikes = { broken: [], working: [] }
    end

    def pick_up_broken_bikes(location)
        location.select_broken_bikes.reverse_each{ |bike| 
            bikes[:broken] << bike
            location.bikes[:broken].delete(bike)
        }
    end

end