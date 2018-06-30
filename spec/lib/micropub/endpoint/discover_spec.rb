describe Micropub::Endpoint::Discover do
  context 'when not given a String' do
    let(:message) { 'url must be a String (given NilClass)' }

    it 'raises an ArgumentError' do
      expect { described_class.new(nil) }.to raise_error(Micropub::Endpoint::ArgumentError, message)
    end
  end

  context 'when given an invalid URL' do
    it 'raises an InvalidURIError' do
      expect { described_class.new('http:') }.to raise_error(Micropub::Endpoint::InvalidURIError)
    end
  end
end