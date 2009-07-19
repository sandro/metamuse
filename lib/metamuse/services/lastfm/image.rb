class Metamuse::Services::Lastfm::Image
  attr_reader :location, :size

  DIMENSIONS = {
    :small => '34x34',
    :medium => '64x64',
    :large => '126x126',
    :extra_large => '300x300'
  }

  def initialize(location)
    @location = location
    set_size
  end

  def dimensions
    DIMENSIONS[size]
  end

  def height
    dimensions.split("x").last
  end

  def width
    dimensions.split("x").first
  end

  private

  def set_size
    @size = DIMENSIONS.index(dimension_value_from_location)
  end

  def dimension_value_from_location
    size_regexp = %r(/serve/(\d+).*/)
    match = location.match size_regexp
    if match && width = match.captures.first
      "#{width}x#{width}"
    end
  end
end
