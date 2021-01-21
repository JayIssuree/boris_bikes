require 'van'

describe Van do

    let(:working_bike) { double :bike, :working? => true }
    let(:broken_bike) { double :bike, :working? => false }
    let(:station) { double :station, 
        :bikes => { working: [working_bike, working_bike], broken:[broken_bike, broken_bike] }
    }
    let(:garage) { double :garage,
        :bikes => { working: [working_bike, working_bike], broken:[] }
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
            expect{ subject.pick_up_broken_bikes(station) }.to raise_error("Van at capacity")
            expect(subject.bikes[:broken].length).to eq(Van::DEFAULT_CAPACITY)
        end

        it 'should initialize a van with a capacity of choice' do
            new_capacity = 5
            subject = Van.new(new_capacity)
            new_capacity.times { station.bikes[:broken] << broken_bike }
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

    describe '#pick_up_working_bikes(garage)' do
        
        it 'should pick up working bikes from a garage' do
            subject.pick_up_working_bikes(garage)
            expect(subject.bikes[:working]).to include(working_bike)
            expect(subject.bikes[:working].length).to eq(2)
            expect(subject.bikes[:broken]).to be_empty
        end

    end

    describe 'drop_off_working_bikes(station)' do
        
        it 'should drop off working bikes to a station' do
            subject.pick_up_working_bikes(garage)
            expect(subject.bikes[:working].length).to eq(2)
            subject.drop_off_working_bikes(station)
            expect(subject.bikes[:working]).to be_empty
            expect(station.bikes[:working].length).to eq(4)
        end

    end

end