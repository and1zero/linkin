module Linkin
  # This is the core of this application
  class Url
    # Not including '1', 'I', 'l', '0', 'O' because it's redundant
    # Removing vocal as well to avoid constructing offensive strings
    ALPHABET = '23456789bcdfghjkmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ-_'.freeze
    SIZE = ALPHABET.length

    # takes number (ID) and convert it into shortened string
    def self.encode(key)
      encoded = ""

      while key > 0 do
        encoded = ALPHABET[key % SIZE] + encoded
        key /= SIZE
      end

      encoded
    end

    # takes shortened string and convert it back to number (ID)
    def self.decode(encoded)
      key = x = 0

      while x < encoded.length do
        key = key * SIZE + ALPHABET.index(encoded[x])
        x += 1
      end

      key
    end
  end
end
