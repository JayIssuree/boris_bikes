require 'van'

describe Van do

    let(:working_bike) { double :bike, :working? => true }
    let(:broken_bike) { double :bike, :working? => false }
    let(:station) { double :station, 
        :bikes => { working: [working_bike, working_bike], broken:[broken_bike, broken_bike] },
        :is_full? => false
    }
    let(:garage) { double :garage,
        :bikes => { working: [working_bike, working_bike], broken:[broken_bike, broken_bike] },
        :is_full? => false
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
            16.times { garage.bikes[:broken] << broken_bike }
            subject.pick_up_broken_bikes(station)
            allow(garage).to receive(:class).and_return("Garage")
            allow(garage).to receive(:is_full?).and_return(true)
            expect{ subject.drop_off_broken_bikes(garage) }
                .to raise_error("Garage is at capacity")
                .and change{ subject.bikes[:broken].length }.by(0)
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

        it 'should not drop off working bikes when the station is at capacity' do
            16.times { station.bikes[:working] << working_bike }
            subject.pick_up_working_bikes(garage)
            allow(station).to receive(:class).and_return("Station")
            allow(station).to receive(:is_full?).and_return(true)
            expect{ subject.drop_off_working_bikes(station) }
                .to raise_error("Station is at capacity")
                .and change{ subject.bikes[:working].length }.by(0)
        end

    end

end