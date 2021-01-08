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
    
end