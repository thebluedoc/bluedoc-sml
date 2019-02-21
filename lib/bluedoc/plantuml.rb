# frozen_string_literal: true

require "zlib"

module BlueDoc
  class Plantuml
    class << self
      def encode(text)
        result = ""
        compressedData = Zlib::Deflate.deflate(text)
        compressedData.chars.each_slice(3) do |bytes|
          # print bytes[0], ' ' , bytes[1] , ' ' , bytes[2]
          b1 = bytes[0].nil? ? 0 : (bytes[0].ord & 0xFF)
          b2 = bytes[1].nil? ? 0 : (bytes[1].ord & 0xFF)
          b3 = bytes[2].nil? ? 0 : (bytes[2].ord & 0xFF)
          result += append3bytes(b1, b2, b3)
        end
        result
      end

      def append3bytes(b1, b2, b3)
        c1 = b1 >> 2
        c2 = ((b1 & 0x3) << 4) | (b2 >> 4)
        c3 = ((b2 & 0xF) << 2) | (b3 >> 6)
        c4 = b3 & 0x3F
        encode6bit(c1 & 0x3F).chr +
               encode6bit(c2 & 0x3F).chr +
               encode6bit(c3 & 0x3F).chr +
               encode6bit(c4 & 0x3F).chr
      end

      def encode6bit(b)
        if b < 10
          return ("0".ord + b).chr
        end
        b = b - 10
        if b < 26
          return ("A".ord + b).chr
        end
        b = b - 26
        if b < 26
          return ("a".ord + b).chr
        end
        b = b - 26
        if b == 0
          return "-"
        end
        if b == 1
          return "_"
        end
        "?"
      end
    end
  end
end
