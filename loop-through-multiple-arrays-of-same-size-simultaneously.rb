var1 = ["a","d","g","j"]
var2 = ["b","e","h","k"]
var3 = ["c","f","i","l"]

var1.zip(var2,var3).each do |vara, varb, varc|
  puts vara
  puts varb
  puts varc
end; puts "done!"

=begin
  :OUTPUT:

1.8.7 :001 > var1 = ["a","d","g","j"]
 => ["a", "d", "g", "j"] 
1.8.7 :002 > var2 = ["b","e","h","k"]
 => ["b", "e", "h", "k"] 
1.8.7 :003 > var3 = ["c","f","i","l"]
 => ["c", "f", "i", "l"] 
1.8.7 :004 > var1.zip(var2)
 => [["a", "b"], ["d", "e"], ["g", "h"], ["j", "k"]] 
1.8.7 :005 > var1.zip(var2,var3)
 => [["a", "b", "c"], ["d", "e", "f"], ["g", "h", "i"], ["j", "k", "l"]] 
1.8.7 :006 > var1.zip(var2,var3).each do |vara, varb, varc|
1.8.7 :007 >     puts vara
1.8.7 :008?>   puts varb
1.8.7 :009?>   puts varc
1.8.7 :010?>   end; puts "done!"
a
b
c
d
e
f
g
h
i
j
k
l
done!
 => nil 
1.8.7 :011 >
=end
