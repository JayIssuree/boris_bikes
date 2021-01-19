require 'garage'

describe Garage do
    
    describe 'state' do

        it 'can store working and broken bikes' do
            expect(subject.bikes[:working]).to be_empty
            expect(subject.bikes[:broken]).to be_empty
        end

    end

end