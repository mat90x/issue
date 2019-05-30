#!lua

-- PiL 2.6. Assume the following code:

-- a = {}; a.a = a

-- What would be the value of a.a.a.a? Is any a in that sequence somehow
-- different from the others?
-- Now, add the next line to the previous code:

-- a.a.a.a = 3

-- What would be the value of a.a.a.a now?

a = {}
a.a = a                       -- table 'a' in key 'a' referring to table 'a'
print("a       = ", a)        
print("a.a     = ", a.a) 
print("a.a.a   = ", a.a.a)    -- key 'a' referring to 'a.a' referring to 'a'
print("a.a.a.a = ", a.a.a.a)  -- key 'a' referring to 'a.a.a' referring 'a'
a.a.a.a = 3
print("a       = ", a)
print("a.a     = ", a.a)      -- print numerical value
print("a.a.a   = ", a.a.a)    -- produces error and crashes program because
                              -- 'a.a.a' (or '3.a') is nil
print("a.a.a.a = ", a.a.a.a)
