require 'van'

describe Van do

    let(:working_bike) { double :bike, :working? => true }
    let(:broken_bike) { double :bike, :working? => false }
    let(:station) { double :station, 
        :bikes => { working: [working_bike, working_bike], broken:[broken_bike, broken_bike] },
        :select_broken_bikes => [broken_bike, broken_bike] 
    }
    let(:garage) { double :garage,
        :bikes => { working: [], broken:[] }
    }
    
    describe '#pick_up_broken_bikes(station)' do
        
        it 'should pick up broken bikes from a station' do
            subject.pick_up_broken_bikes(station)
            expect(subject.bikes[:broken]).to include(broken_bike)
            expect(subject.bikes[:broken].length).to eq(2)
            expect(subject.bikes[:working]).to be_empty
        end

        it 'should not pick up a broken bike when at defualt capacity' do
            Van::DEFAULT_CAPACITY.times { station.bikes[:broken] << broken_bike }
            Van::DEFAULT_CAPACITY.times { station.select_broken_bikes << broken_bike }
            expect{ subject.pick_up_broken_bikes(station) }.to raise_error("Van at capacity")
            expect(subject.bikes[:broken].length).to eq(Van::DEFAULT_CAPACITY)
        end

        it 'should initialize a van with a capacity of choice' do
            new_capacity = 5
            subject = Van.new(new_capacity)
            new_capacity.times { station.bikes[:broken] << broken_bike }
            new_capacity.times { station.select_broken_bikes << broken_bike }
            expect{ subject.pick_up_broken_bikes(station) }.to raise_error("Van at capacity")
            expect(subject.bikes[:broken].length).to eq(new_capacity)
        end

    end

    describe '#drop_off_broken_bikes(garage)' do
        
        it 'should drop off broken bikes to a garage' do
            subject.pick_up_broken_bikes(station)
            expect(subject.bikes[:broken].length).to eq(2)
            subject.drop_off_broken_bikes(garage)
            expect(subject.bikes[:broken]).to be_empty
            expect(garage.bikes[:broken].length).to eq(2)
        end

    end

end