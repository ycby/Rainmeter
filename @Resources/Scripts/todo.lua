--The WriteFile and ReadFile sections of code were taken from the rainmeter snippets
--at https://docs.rainmeter.net/snippets/read-write-file/

savepath = "C:\\Users\\Pikachu\\Documents\\Rainmeter\\Skins\\MyCustomSkin\\@Resources\\State\\todo.txt"
itemmeterpath = "C:\\Users\\Pikachu\\Documents\\Rainmeter\\Skins\\MyCustomSkin\\TodoList\\ItemMeters.inc"

baseX = 10
checkboxX = 395
baseY = 70
width = 390
height = 20
cross_font_y = 10

checkbox_width = 20
checkbox_height = 20

checkbox_to_check_offset = 6

check_width = checkbox_width - checkbox_to_check_offset
check_height = checkbox_height - checkbox_to_check_offset

checkX = checkbox_width - checkbox_to_check_offset / 2
checkY = checkbox_height - checkbox_to_check_offset / 2

toi_todo = {}
toi_items = {}
toi_hidden = {}

function Initialize()

	PerformChecking()
end

function PerformChecking()

    ParseTodoFile()
    print("Todo Parse Passed")
    ParseItemsFile()
    print("Items Parse Passed")
    if (CompareTodoAndItems()) then
        print("Compare Successful")
    else
        print("Failed")
    end
end

function ParseTodoFile()

    local todo_contents = ReadFile(savepath)

    local itemNo = 1

    for newline in string.gmatch(todo_contents, "[^\n]+") do
        --print("todo: " .. itemNo .. " " .. newline)

        toi_todo[itemNo] = newline

        itemNo = itemNo + 1
    end
end

function ParseItemsFile()

    local items_contents = ReadFile(itemmeterpath)

    local itemNo = 1

    for newline in string.gmatch(items_contents, "Text = (.-)\n") do
        --print("items: " .. itemNo .. " " .. newline)

        toi_items[itemNo] = newline

        itemNo = itemNo + 1
    end

	itemNo = 1

	for hidden in string.gmatch(items_contents, "Hidden = (%d)\n") do

        toi_hidden[itemNo] = hidden

        itemNo = itemNo + 1
    end
end

function CompareTodoAndItems()

    local todo_len = #toi_todo
    local item_len = #toi_items

    if (todo_len ~= item_len) then
        print("Wrong Number of Items")
        WriteInMemoryToFile()
        return false
    end

    for i = 1, todo_len do

        local todo_item = toi_todo[i]
        local item_item = toi_items[i]

        if (todo_item ~= item_item) then
            print("Unsuccessful Compare")
            WriteInMemoryToFile()
            return false
        end

    end

    return true
end

function ToggleCheck(itemNo)

	if (toi_hidden[itemNo] == 0) then
		toi_hidden[itemNo] = 1
	else
		toi_hidden[itemNo] = 0
	end
end

function ToggleStrikethrough(itemNo)

	meter = "MeterItem" .. itemNo

	itemMeter = SKIN:GetMeter(meter)

	if (itemMeter == nil) then
		return
	end

	if (itemMeter:GetOption("InlineSetting") == "None") then
		SKIN:Bang("!SetOption", meter, "InlineSetting", "Strikethrough")
	else
		SKIN:Bang("!SetOption", meter, "InlineSetting", "None")
	end
end
-----------------------------------------------------------------

--Function to write out the Meter section in the inc file
function GenerateMeterString(itemNo, newline)

    return "[MeterItem" .. itemNo .. "]\n" ..
            "Meter = String\n" ..
            "MeterStyle = inputStyle\n" ..
            "Group = " .. itemNo .. "\n" ..
            "X = " .. baseX .. "\n" ..
            "Y = ([MeterItem" .. (itemNo - 1) .. ":Y] + [MeterItem" .. (itemNo - 1) .. ":H] + 4)\n" ..
            "W = " .. width .. "\n" ..
            "Text = " .. newline .. "\n" ..
			"ClipString = 2\n" ..
			"InlineSetting = None\n" ..
			"DynamicVariables = 1\n"
end

function GenerateMeterCheckbox(itemNo)

	return "[MeterCheckBox" .. itemNo .. "]\n" ..
			"Meter = Image\n" ..
			"ImageName = #@#Images\\checkbox.png\n" ..
			"X = " .. checkboxX .. "\n" ..
			"Y = ([MeterItem" .. itemNo .. ":Y] + ([MeterItem" .. itemNo .. ":H] / 2) - 10)\n" ..
			"W = " .. checkbox_width .. "\n" ..
			"H = " .. checkbox_height .. "\n" ..
			"LeftMouseUpAction = [!ToggleMeter \"MeterCheck" .. itemNo .. "\"][!CommandMeasure \"MeasureTodoScript\" \"ToggleStrikethrough(" .. itemNo .. ")\"][!CommandMeasure \"MeasureTodoScript\" \"ToggleCheck(" .. itemNo .. ")\"][!UpdateMeter MeterItem" .. itemNo .. "][!Redraw]\n" ..
			"DynamicVariables = 1\n"
end

function GenerateMeterCheck(itemNo)

	return "[MeterCheck" .. itemNo .. "]\n" ..
			"Meter = Image\n" ..
			"ImageName = #@#Images\\check.png\n" ..
			"X = -" .. checkX .. "R\n" ..
			"Y = -" .. checkY .."R\n" ..
			"W = " .. check_width .. "\n" ..
			"H = " .. check_height .. "\n" ..
			"Hidden = " .. toi_hidden[itemNo] .."\n"
end

function WriteInMemoryToFile()

	local to_write = "[MeterItem0]\n" ..
						"Meter = String\n" ..
						"X = 0R\n" ..
						"Y = 5R\n"

	for i, v in ipairs(toi_todo) do

		if (toi_hidden[i] == nil) then
			toi_hidden[i] = 1
		end

		local meter = GenerateMeterString(i, v)

		local checkbox = GenerateMeterCheckbox(i)

		local check = GenerateMeterCheck(i)

		local item_string = meter ..
							checkbox ..
							check ..
							";endItem" .. i ..
							"\n"

		to_write = to_write .. item_string

	end

	WriteFile(to_write, itemmeterpath)
	RefreshSkin()
end
-----------------------------------------------------------------

function EnterInput(content)

	if (content == "") then

		return
	end

    local todo_len = #toi_todo + 1

	toi_todo[todo_len] = content
	toi_hidden[todo_len] = 1

	if (#toi_todo > 1) then

		content = "\n" .. content
	end

	AppendFile(content, savepath)

	WriteInMemoryToFile()
end

function RefreshSkin()

	SKIN:Bang("!Refresh")
end

-----------------------------------------------------------------

function ReadFile(filepath)
	-- HANDLE RELATIVE PATH OPTIONS.
	--savepath = SKIN:MakePathAbsolute(savepath)

	--print("This has been called")
	-- OPEN FILE.
	local File = io.open(filepath)

	-- HANDLE ERROR OPENING FILE.
	if not File then
		print('ReadFile: unable to open file at ' .. filepath)
		return
	end

	-- READ FILE CONTENTS AND CLOSE.
	local Contents = File:read('*all')
	File:close()

	return Contents
end

--Amended from the original code to make it append instead of overwrite
function WriteFile(Contents, filepath)
	-- HANDLE RELATIVE PATH OPTIONS.
	--savepath = SKIN:MakePathAbsolute(savepath)

	-- OPEN FILE.
	local File = io.open(filepath, 'w')

	-- HANDLE ERROR OPENING FILE.
	if not File then
		print('WriteFile: unable to open file at ' .. filepath)
		return
	end

	-- WRITE CONTENTS AND CLOSE FILE
	File:write(Contents)
	File:close()

	return true
end

function AppendFile(Contents, filepath)
	-- HANDLE RELATIVE PATH OPTIONS.
	--savepath = SKIN:MakePathAbsolute(savepath)

	-- OPEN FILE.
	local File = io.open(filepath, 'a')

	-- HANDLE ERROR OPENING FILE.
	if not File then
		print('WriteFile: unable to open file at ' .. filepath)
		return
	end

	-- WRITE CONTENTS AND CLOSE FILE
	File:write(Contents)
	File:close()

	return true
end
