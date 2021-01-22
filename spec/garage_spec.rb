require 'garage'
require 'support/shared_examples_for_bike_container'

describe Garage do

    it_behaves_like BikeContainer

    let(:broken_bike) { double :bike, :working => false, :fix => nil }
    
    describe 'state' do

        it 'can store working and broken bikes' do
            expect(subject.bikes[:working]).to be_empty
            expect(subject.bikes[:broken]).to be_empty
        end

        it 'should initilize with a default capacity' do
            expect(subject.capacity).to eq(Garage::DEFAULT_CAPACITY)
        end

        it 'can initialize with a capacity of choice' do
            new_capacity = 5
            subject = Garage.new(5)
            expect(subject.capacity).to eq(new_capacity)
        end

    end

    describe '#fix_broken_bikes' do
        
        it 'should fix broken bikes' do
            subject.bikes[:broken] << broken_bike
            expect(broken_bike).to receive(:fix)
            subject.fix_broken_bikes
        end

        it 'should move fixed bikes to the correct array' do
            subject.bikes[:broken] << broken_bike
            expect{ subject.fix_broken_bikes }
                .to change{ subject.bikes[:broken].length }.by(-1)
                .and change{ subject.bikes[:working].length }.by(1)
        end

    end

end