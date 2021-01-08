require 'docking_station'

describe DockingStation do

    describe '#release_bike' do
        
        it 'should respond to release_bike method' do
            expect(subject).to respond_to(:release_bike)
        end

        it 'should release a bike object' do
            expect(subject.release_bike).to be_an_instance_of(Bike)
        end

        it 'should release working bike' do
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