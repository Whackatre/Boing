# Pseudo-random number generation.

# Returns a random int (range included).
def random(range)
  return rand(range + 1)
end

# Returns a random int (range included).
def random_range(low, high)
  return random(high - low) + low
end

# Returns a random float of the given range.
def randomf(range)
  return rand * range
end

# Returns a random float between low and high.
def randomf_range(low, high)
  return rand * (high - low) + low
end

# Returns a random opaque color.
def random_color
  return Color.new(random(COL_DEP), random(COL_DEP), random(COL_DEP), 255)
end