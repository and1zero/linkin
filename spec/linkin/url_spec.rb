require 'spec_helper'

describe Linkin::Url do
  let(:described_class) { Linkin::Url }

  describe '.encode' do
    it 'is able to encode short key' do
      assert_equal 'b', described_class.encode(1)
    end

    it 'is able to encode long keys' do
      key = 4*(64**3) + 2*(64**2) + 8*(64**1) + 9*(64**0)

      # alphabet[4] + alphabet[2] + alphabet[8] + alphabet[9]
      assert_equal 'ecij', described_class.encode(key)
    end
  end

  describe '.decode' do
    it 'is able to decode short string' do
      assert_equal 1, described_class.decode('b')
    end

    it 'is able to decode long strings' do
      key = 4*(64**3) + 2*(64**2) + 8*(64**1) + 9*(64**0)

      assert_equal key, described_class.decode('ecij')
    end
  end
end
