#!lua
-- PiL 2.4. How can you embed the following piece of XML as a string in Lua?
-- <![CDATA[
--   Hello world
-- ]]>
-- Show at least two different ways.

str1 = [=[
<!CDATA[
  Hello world
]]>]=]

str2 = "<!CDATA[\n  Hello world\n]]>"

str3 = '<![CDATA[\
  Hello world\
]]>'

print(str1)
print(str2)
print(str3)
