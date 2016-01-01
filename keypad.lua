local monitor = assert(peripheral.find("monitor"), "Could Not Find Keypad")
local x, y = monitor.getSize()
local xBuff, yBuff = ((x - 3) / 2), ((y - 3) / 2)

monitor.setTextScale(1)
monitor.clear()

function writeRow(layer, txt)
    monitor.setCursorPos(xBuff + 1, yBuff + layer)
    monitor.write(txt)
end
writeRow(1, "123")
writeRow(1, "456")
writeRow(1, "789")

local combo = {1, 2, 3, 4}
local comboPos = 1
while true do
    event, clickX, clickY = os.pullEvent("monitor_touch")
    if (clickX > xBuff) and (clickX < (xBuff + 4)) and (clickY > yBuff) and (clickY < (yBuff + 4)) then
        --Do This
