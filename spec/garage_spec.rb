require 'garage'
require 'support/shared_examples_for_bike_container'

describe Garage do

    it_behaves_like BikeContainer
    
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

end