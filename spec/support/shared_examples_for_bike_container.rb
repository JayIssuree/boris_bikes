shared_examples_for BikeContainer do

    let(:working_bike) { double :bike, :working => true }
    let(:broken_bike) { double :bike, :working => false }

    describe '#capacity' do
        
        it 'has a default capacity when initialized' do
            expect(subject.capacity).to eq BikeContainer::DEFAULT_CAPACITY
        end
    
        it 'can initialize with a capacity of choice' do
            random_capacity = Random.rand(100)
            subject = described_class.new(random_capacity)
            expect(subject.capacity).to eq(random_capacity)
        end

        it 'should state whether it is full or not' do
            expect(subject.is_full?).to be(false)
            subject.capacity.times { subject.bikes[:working] << working_bike }
            expect(subject.is_full?).to be(true)

        end

    end

    describe 'storing bikes' do

        it 'can store a working bike' do
            expect{ subject.bikes[:working] << working_bike }
                .to change{ subject.bikes[:working].length }.by(1)
                .and change{ subject.bikes[:broken].length }.by(0)
        end

        it 'can store a broken bike' do
            expect{ subject.bikes[:broken] << broken_bike }
                .to change{ subject.bikes[:broken].length }.by(1)
                .and change{ subject.bikes[:working].length }.by(0)
        end

    end

end