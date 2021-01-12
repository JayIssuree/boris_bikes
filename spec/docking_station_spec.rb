require 'docking_station'

describe DockingStation do

    describe '#release_bike' do
        
        it 'should respond to release_bike method' do
            expect(subject).to respond_to(:release_bike)
        end

        it 'should raise an error if there are no bikes to release' do
            expect { subject.release_bike }.to raise_error("No bikes available")
        end

        it 'should release a bike object' do
            bike = Bike.new
            subject.dock(bike)
            expect(subject.release_bike).to eq(bike)
        end

        it 'should release working bike' do
            subject.dock(Bike.new)
            expect(subject.release_bike.working?).to be(true)
        end

        it 'the docking station should not contain the realeased bike' do
            bike = Bike.new
            subject.dock(bike)
            subject.release_bike
            expect(subject.bikes).to be_empty
        end

    end

    describe '#dock(bike)' do
        
        it 'should respond to dock method' do
            expect(subject).to respond_to(:dock).with(1).argument
        end

        it 'should return the docked bike' do
            bike = Bike.new
            expect(subject.dock(bike)).to eq(bike)
        end

        it 'should not dock a bike when at defualt capacity' do
            DockingStation::DEFAULT_CAPACITY.times { subject.dock(Bike.new) }
            expect{ subject.dock(Bike.new) }.to raise_error("Docking station at capacity")
        end

        it 'should initialize a docking station with a capacity of choice' do
            new_capacity = 5
            subject = DockingStation.new(new_capacity)
            new_capacity.times { subject.dock(Bike.new) }
            expect{ subject.dock(Bike.new) }.to raise_error("Docking station at capacity")
        end

    end
    
end