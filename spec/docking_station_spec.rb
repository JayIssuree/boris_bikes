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
            bike = Bike.new
            subject.dock(bike)
            expect(subject.release_bike.working?).to be(true)
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

    end
    
end