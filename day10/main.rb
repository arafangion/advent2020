#file = File.read("small_example.data")
#file = File.read("example.data")
file = File.read("input.data")
original_input = file.strip.lines.map { | line | line.strip.to_i }.sort_by { | line | line }

input = original_input.map{|e|e}
pairs = (input.insert(0, 0)).zip input.drop(1).append(input.last + 3)

items = pairs.map { | (a, b) |
	b-a
}

jolts1 = items.filter{ | item | item == 1 }.count
jolts3 = items.filter{ | item | item == 3 }.count
puts "Day 10, part 1: #{jolts1*jolts3}"

# The question implies that it's computationally expensive to naively brute-force
# generate all possible combinations and filter them.  So, just generate the correct
# options up-front:

def find_arrangements(prefix, start, items, last)
	if items != [] then
		r = items.map { |item|
			if item - start <= 3 then
				rest = items.select { |elem| elem > item }
				find_arrangements(prefix + [start], item, rest, last)
			else
				[]
			end
		}.flatten 1
		r
	else
		if last - start <= 3 then
			[prefix + [start, last]]
		else
			[]
		end
	end
end

# Previous attempt was much to slow and memory hungry; second attempt, which requires the input
# be sorted
$memo = {}
def find_arrangements2(start, index_start, count, items)
	mk = [start, index_start]
	if $memo.include? mk then
		return $memo[mk]
	end
	sum = 0
	while index_start < count do
		item = items[index_start]
		index_start += 1
		diff = item - start

		if diff <= 3 then
			if count - index_start <= 1 then
				sum += 1
			else
				sum += find_arrangements2(item, index_start, count, items)
			end
		else
			break
		end
	end
	$memo[mk] = sum
	return sum
end

sorted_input = original_input.sort_by{ |e| e }
puts "Day 10, Part 2: #{find_arrangements2(0, 0, sorted_input.count, sorted_input)}"

