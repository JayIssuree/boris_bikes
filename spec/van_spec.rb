require 'van'

describe Van do

    let(:working_bike) { double :bike, :working? => true }
    let(:broken_bike) { double :bike, :working? => false }
    let(:station) { double :station, 
        :bikes => { working: [working_bike, working_bike], broken:[broken_bike, broken_bike] }
    }
    let(:garage) { double :garage,
        :bikes => { working: [working_bike, working_bike], broken:[broken_bike, broken_bike] }
    }

    describe '#initialize' do
        
        it 'should initialize a van with a capacity of choice' do
            new_capacity = 5
            subject = Van.new(new_capacity)
            new_capacity.times { station.bikes[:broken] << broken_bike }
            expect{ subject.pick_up_broken_bikes(station) }.to raise_error("Van at capacity")
            expect(subject.bikes[:broken].length).to eq(new_capacity)
        end

    end
    
    describe '#pick_up_broken_bikes(station)' do
        
        it 'should pick up broken bikes from a station' do
            expect{ subject.pick_up_broken_bikes(station) }
                .to change { subject.bikes[:broken].length }.by(2)
                .and change { station.bikes[:broken].length}.by(-2)
            expect(station.bikes[:broken]).to be_empty
            expect(subject.bikes[:working]).to be_empty
        end

        it 'should not pick up a broken bike when at defualt capacity' do
            Van::DEFAULT_CAPACITY.times { station.bikes[:broken] << broken_bike }
            expect{ subject.pick_up_broken_bikes(station) }.to raise_error("Van at capacity")
            expect(subject.bikes[:broken].length).to eq(Van::DEFAULT_CAPACITY)
        end

    end

    describe '#drop_off_broken_bikes(garage)' do
        
        it 'should drop off broken bikes to a garage' do
            subject.pick_up_broken_bikes(station)
            expect{ subject.drop_off_broken_bikes(garage) }
                .to change { subject.bikes[:broken].length }.by(-2)
                .and change { garage.bikes[:broken].length }.by(2)
            expect(subject.bikes[:broken]).to be_empty
        end

        it 'should not drop off broken bikes when the garage is at capacity' do
            
        end

    end

    describe '#pick_up_working_bikes(garage)' do
        
        it 'should pick up working bikes from a garage' do
            expect{ subject.pick_up_working_bikes(garage) }
                .to change { subject.bikes[:working].length }.by(2)
                .and change { garage.bikes[:working].length}.by(-2)
            expect(garage.bikes[:working]).to be_empty
            expect(subject.bikes[:broken]).to be_empty
        end

        it 'should not pick up a working bike when at defualt capacity' do
            Van::DEFAULT_CAPACITY.times { garage.bikes[:working] << working_bike }
            expect{ subject.pick_up_working_bikes(garage) }.to raise_error("Van at capacity")
            expect(subject.bikes[:working].length).to eq(Van::DEFAULT_CAPACITY)
        end

    end

    describe 'drop_off_working_bikes(station)' do
        
        it 'should drop off working bikes to a station' do
            subject.pick_up_working_bikes(garage)
            expect{ subject.drop_off_working_bikes(station) }
                .to change { subject.bikes[:working].length }.by(-2)
                .and change { station.bikes[:working].length}.by(2)
            expect(subject.bikes[:working]).to be_empty
        end

    end

end