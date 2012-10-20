# Pseudo-random number generation.

def random(range)
	return rand(range + 1)
end

def random_range(low, high)
	return random(high - low) + low
end

def randomf(range)
	return rand * range
end

def randomf_range(low, high)
	return rand * (high - low) + low
end