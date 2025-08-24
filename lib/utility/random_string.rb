# frozen_string_literal: true

module Utility
  class RandomString
    def self.alphanumeric(size = 10)
      SecureRandom.alphanumeric(size)
    end
  end
end
