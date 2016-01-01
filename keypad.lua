local monitor = assert(peripheral.find("monitor"), "Could Not Find Keypad")

monitor.setTextScale(1)
monitor.clear()

local x, y = monitor.getSize()
if (math.floor(x / 2) * 2) == x then
    x = x - 1
end
if (math.floor(y / 2) * 2) == y then
    y = y - 1
end
local xBuff, yBuff = ((x - 3) / 2), ((y - 3) / 2)

function writeRow(layer, txt)
    monitor.setCursorPos(xBuff + 1, yBuff + layer)
    monitor.write(txt)
end

function redraw()
    print("Redrawing keypad...")
    monitor.clear()
    writeRow(1, "123")
    writeRow(2, "456")
    writeRow(3, "789")
end

redraw()

local combo = {1, 2, 3, 4} --The first nil value is the end of the array
local comboPos = 1
while true do
    event, side, clickX, clickY = os.pullEvent("monitor_touch")
    local keyX, keyY = nil, nil
    local pressed = nil
    if (clickX > xBuff) and (clickX < (xBuff + 4)) and (clickY > yBuff) and (clickY < (yBuff + 4)) then
        keyX, keyY = (clickX - xBuff), (clickY - yBuff)
        pressed = keyX + ((keyY - 1) * 3)
    end
    if pressed and (pressed == combo[comboPos]) then
        comboPos = comboPos + 1
        if not combo[comboPos] then
            break
        end
    elseif pressed then
        comboPos = 1
        monitor.clear()
        writeRow(2, "!!!")
        sleep(1)
        redraw()
    end
end

monitor.clear()
writeRow(2, "CLOSE")

rs.setOutput("bottom", true)
os.pullEvent("monitor_touch")
rs.setOutput("bottom", false)
monitor.clear()
writeRow(2, ":)")
sleep(1)
os.reboot()
