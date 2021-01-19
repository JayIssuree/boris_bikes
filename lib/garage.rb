class Garage

    attr_reader :bikes

    def initialize
        @bikes = { working: [], broken: [] }
    end

end
