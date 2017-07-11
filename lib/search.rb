class Search
  attr_reader :data
  def initialize(data)
    @data = data
  end

  def has_key?(key)
    @data.first.key?(key)
  end

  def find_all(key, value)
    @data.select do  |element| 
    	next element[key].to_s == value unless element[key].is_a?(Array)
    	element[key].find {|w|  w == value }
    end
  end

  def list_all_fields
    @data.first.keys
  end
end
