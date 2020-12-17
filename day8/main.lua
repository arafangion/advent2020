
function acc (arg)
	accumulator = accumulator + arg
end

function jump (offset)
	program_counter = program_counter + offset -1
end

function nop ()
end

function load_program(filename)
	accumulator = 0
	program_counter = 0
	program = {}
	counters = {}

	for line in io.lines(filename) do
		local items = string.gmatch(line, "%S+")
		table.insert(program, {items(), tonumber(items())})
	end
	--print("Program loaded")
end

function part1(filename)
	--print("OP", "ARG", "ACC", "PC", "Next", "Count")
	while true do
		local instruction = program[program_counter+1]
		if instruction == nil then
			--print("Program Completed")
			return
		end
		local current_pc = program_counter
		if counters[program_counter + 1] == nil then
			counters[program_counter + 1] = 1
		else
			--counters[program_counter + 1] = counters[program_counter + 1] + 1
			return accumulator
		end

		local op = instruction[1]
		local arg = instruction[2]

		
		if op == "acc" then acc(arg) end
		if op == "jmp" then jump(arg) end
		if op == "nop" then nop() end

		program_counter = program_counter + 1
		--print(op, arg, accumulator, current_pc, program_counter, counters[current_pc + 1])
	end
end

function part2(corrupt_index, original_op, corrected_op)
	local ops = 0

	--print("OP", "ARG", "ACC", "PC", "Next", "Count")
	while ops < limit do
		local instruction = program[program_counter+1]
		local current_pc = program_counter
		if #program == program_counter and ops < limit - 1 then
			return accumulator
		end
		if instruction == nil then
			--print("Program already completed")
			return 
		end
		if counters[program_counter + 1] == nil then
			counters[program_counter + 1] = 1
		else
			counters[program_counter + 1] = counters[program_counter + 1] + 1
		end

		local op = instruction[1]
		if program_counter == corrupt_index and op == original_op then
			op = corrected_op
		end
		local arg = instruction[2]

		
		if op == "acc" then acc(arg) end
		if op == "jmp" then jump(arg) end
		if op == "nop" then nop() end

		program_counter = program_counter + 1
		ops = ops + 1
		--print(op, arg, accumulator, current_pc, program_counter, counters[current_pc + 1])
	end
end

load_program("input.data")
print("Day 8, part 1", part1())

load_program("input.data")
limit = 1000
for bad = 0, #program-1 do
	accumulator = 0
	program_counter = 0
	counters = {}
	result = part2(bad, 'jmp', 'nop')
	if result ~= nil then
		print("Day 8, part 2", result)
	end
	accumulator = 0
	program_counter = 0
	counters = {}
	result = part2(bad, 'nop', 'jmp')
	if result ~= nil then
		print("Day 8, part 2", result)
	end
end
