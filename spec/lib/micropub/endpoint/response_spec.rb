describe Micropub::Endpoint::Response do
  context 'when not given an Addressable::URI' do
    let(:message) { 'uri must be an Addressable::URI (given NilClass)' }

    it 'raises an ArgumentError' do
      expect { described_class.new(nil) }.to raise_error(Micropub::Endpoint::ArgumentError, message)
    end
  end
end
