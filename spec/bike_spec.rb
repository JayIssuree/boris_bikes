require 'bike'

describe Bike do
    
    describe '#working?' do
        
        it 'should respond to working?' do
            expect(subject).to respond_to(:working?)
        end

    end

end