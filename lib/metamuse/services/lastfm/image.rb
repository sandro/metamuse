class Metamuse::Services::Lastfm::Image
  attr_reader :location, :size

  DIMENSIONS = {
    "34x34"   => :small,
    "64x64"   => :medium,
    "126x126" => :large,
    "252x247" => :extra_large,
    "300x300" => :extra_large
  }

  def initialize(location)
    @location = location
    set_size
  end

  def dimensions
    DIMENSIONS.index size
  end

  def height
    dimensions.split("x").last
  end

  def width
    dimensions.split("x").first
  end

  private

  def set_size
    dimension = DIMENSIONS.keys.detect {|d| d =~ %r(^#{width_from_location}x)}
    @size = DIMENSIONS[dimension]
  end

  def width_from_location
    size_regexp = %r(/serve/(\d+).*/)
    match = location.match size_regexp
    match && match.captures.first
  end
end
