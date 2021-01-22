require 'bike'

describe Bike do
    
    describe '#working?' do
        
        it 'should respond to working?' do
            expect(subject).to respond_to(:working?)
        end

        it 'should be working by default' do
            expect(subject).to be_working
        end

    end

    describe '#report_broken' do
        
        it 'should not be working when reported broken' do
            subject.report_broken
            expect(subject).not_to be_working
        end

    end

    describe '#fix' do
        
        it 'should fix a broken bike' do
            subject.report_broken
            subject.fix
            expect(subject.working?).to be(true)
        end

    end

end