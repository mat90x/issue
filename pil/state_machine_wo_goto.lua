#!lua
-- PiL 4.4. Rewrite the state machine of Listing 4.2 without using goto

state = 1

while true do
  local c = io.read(1)
  if state == 1 and c == '0' then state = 2
  elseif state == 2 and c == '0' then state = 1
  elseif c == nil then
    if state == 1 then print 'ok' end
    if state == 2 then print 'not ok' end
    break
  end
end
