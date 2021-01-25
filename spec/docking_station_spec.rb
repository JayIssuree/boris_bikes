require 'docking_station'
require 'support/shared_examples_for_bike_container'

describe DockingStation do

    it_behaves_like BikeContainer

    let(:working_bike) { double :bike, :working? => true }
    let(:working_bike2) { double :bike, :working? => true }
    let(:broken_bike) { double :bike, :working? => false }
    let(:random_object) { double :random_object }

    before(:each) do        
        allow(working_bike).to receive(:is_a?).with(Bike).and_return(true)
        allow(working_bike2).to receive(:is_a?).with(Bike).and_return(true)
        allow(broken_bike).to receive(:is_a?).with(Bike).and_return(true)
    end

    describe '#release_bike' do
        
        it 'should respond to release_bike method' do
            expect(subject).to respond_to(:release_bike)
        end

        it 'should raise an error if there are no bikes to release' do
            expect { subject.release_bike }.to raise_error("No working bikes available")
        end

        it 'should release a bike object' do
            subject.dock(working_bike)
            expect(subject.release_bike).to eq(working_bike)
        end

        it 'should release working bike' do
            subject.dock(working_bike)
            expect(subject.release_bike.working?).to be(true)
        end

        it 'the docking station should not contain the realeased bike' do
            subject.dock(working_bike)
            subject.release_bike
            expect(subject.bikes[:working]).to be_empty
        end

        it 'should not release a broken bike' do
            subject.dock(broken_bike)
            expect { subject.release_bike }.to raise_error("No working bikes available")
            expect(subject.bikes[:broken]).to include(broken_bike)
        end

        it 'should not release a broken bike no matter what position it is stored in @bikes' do
            subject.dock(working_bike)
            subject.dock(broken_bike)
            expect(subject.release_bike).to eq(working_bike)
            expect(subject.bikes[:broken]).to include(broken_bike)
        end

    end

    describe '#release_chosen_bike(bike)' do
        
        it 'should release the bike of choice' do
            subject.dock(working_bike)
            subject.dock(working_bike2)
            expect(subject.release_chosen_bike(working_bike2)).to eq(working_bike2)
            expect(subject.bikes[:working]).to_not include(working_bike2)
        end

        it 'should raise an error when attempting to release a broken bike' do
            subject.dock(working_bike)
            subject.dock(broken_bike)
            expect{ subject.release_chosen_bike(broken_bike) }.to raise_error("This bike is not available")
        end

    end

    describe '#dock(bike)' do
        
        it 'should respond to dock method' do
            expect(subject).to respond_to(:dock).with(1).argument
        end

        it 'should raise an error when attempting to dock something other than a bike' do
            expect{ subject.dock(random_object) }.to raise_error("Object is not a Bike")
        end

        it 'should return the docked working bike' do
            expect(subject.dock(working_bike)).to eq(working_bike)
        end

        it 'should return the docked broken bike' do
            expect(subject.dock(broken_bike)).to eq(broken_bike)
        end

        it 'should not dock a bike when at defualt capacity' do
            DockingStation::DEFAULT_CAPACITY.times { subject.dock(broken_bike) }
            expect{ subject.dock(broken_bike) }.to raise_error("Docking station at capacity")
        end

        it 'should initialize a docking station with a capacity of choice' do
            new_capacity = 5
            subject = DockingStation.new(new_capacity)
            new_capacity.times { subject.dock(working_bike) }
            expect{ subject.dock(broken_bike) }.to raise_error("Docking station at capacity")
        end

    end
    
end