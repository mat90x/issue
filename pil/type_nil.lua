#!lua
-- PiL 2.1. What is th value of the expression type(nil)==nil? Can you explain
-- this result?

-- The result will be false because type(nil) produces string as a result, and
-- string is considered as positive whenever nil is negative

print ( "type of type(nil) is "..type(type(nil)) )
print ( "type(nil)==nil equals "..tostring(type(nil)==nil) )
