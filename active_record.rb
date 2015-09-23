class Word < ActiveRecord::Base
  attr_accessor :words

  def initialize
    self.words = words
  end
end

class Meaning < ActiveRecord::Base
  attr_accessor :meanings

  def initialize
    self.meanings = meanings
  end
end
