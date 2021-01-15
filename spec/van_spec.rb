require 'van'

describe Van do

    let(:working_bike) { double :bike, :working? => true }
    let(:broken_bike) { double :bike, :working? => false }
    let(:station) { double :station, 
        :bikes => { working: [working_bike, working_bike], broken:[broken_bike, broken_bike] },
        :select_broken_bikes => [broken_bike, broken_bike] 
    }
    
    describe '#pick_up_broken_bikes(station)' do
        
        it 'should pick up broken bikes from a station' do
            subject.pick_up_broken_bikes(station)
            expect(subject.bikes[:broken]).to include(broken_bike)
            expect(subject.bikes[:broken].length).to eq(2)
            expect(subject.bikes[:working]).to be_empty
        end

    end

end