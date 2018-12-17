#---
# Excerpted from "Mastering Ruby Closures",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/btrubyclo for more book information.
#---
# reducer = lambda do |acc, arr, binary_function| => original first line
REDUCER = lambda do |acc, arr, binary_function|
  reducer_aux = lambda do |acc, arr|
    puts
    puts "current accumulator value at the top of the lambda definiton: #{acc}"
    puts "current array value at the top of the lambda defintion: #{arr.inspect}"
    if arr.empty?
      puts
      puts "have reached recursive stop condition"
      puts "current accumulator value: #{acc}"
      puts "current array value: #{arr.inspect}"
      acc
    else
      foo = binary_function
      puts
      puts caller[0]
      puts "return value of binary_function: #{foo.call(acc, arr.first)}"
      puts "current accumulator value: #{acc}"
      puts "current array value: #{arr.inspect}"
      reducer_aux.call(binary_function.call(acc, arr.first), arr.drop(1))
    end
  end
  puts "This is the initial call to reducer_aux"
  reducer_aux.call(acc, arr)
end

=begin
Here is the output when I run the following test:

assert_equal(15, reducer.call(0, (1..5).to_a, lambda { |x, y| x + y }))

OUTPUT
***********************************************************************

This is the initial call to reducer_aux

current accumulator value at the top of the lambda definition: 0
current array value at the top of the lambda defintion: [1, 2, 3, 4, 5]

/Users/ericricketts/Documents/RubyBooks/MasteringRubyClosures/code/closures/reducer.rb:32:in `block in <top (required)>'
return value of binary_function: 1
current accumulator value: 0
current array value: [1, 2, 3, 4, 5]

current accumulator value at the top of the lambda definition: 1
current array value at the top of the lambda defintion: [2, 3, 4, 5]

/Users/ericricketts/Documents/RubyBooks/MasteringRubyClosures/code/closures/reducer.rb:28:in `block (2 levels) in <top (required)>'
return value of binary_function: 3
current accumulator value: 1
current array value: [2, 3, 4, 5]

current accumulator value at the top of the lambda definition: 3
current array value at the top of the lambda defintion: [3, 4, 5]

/Users/ericricketts/Documents/RubyBooks/MasteringRubyClosures/code/closures/reducer.rb:28:in `block (2 levels) in <top (required)>'
return value of binary_function: 6
current accumulator value: 3
current array value: [3, 4, 5]

current accumulator value at the top of the lambda definition: 6
current array value at the top of the lambda defintion: [4, 5]

/Users/ericricketts/Documents/RubyBooks/MasteringRubyClosures/code/closures/reducer.rb:28:in `block (2 levels) in <top (required)>'
return value of binary_function: 10
current accumulator value: 6
current array value: [4, 5]

current accumulator value at the top of the lambda definition: 10
current array value at the top of the lambda defintion: [5]

/Users/ericricketts/Documents/RubyBooks/MasteringRubyClosures/code/closures/reducer.rb:28:in `block (2 levels) in <top (required)>'
return value of binary_function: 15
current accumulator value: 10
current array value: [5]

current accumulator value at the top of the lambda definition: 15
current array value at the top of the lambda defintion: []

have reached recursive stop condition
current accumulator value: 15
current array value: []

***********************************************************************
END OUTPUT


In the test I assigned an attr_accessor called reducer to the above REDUCER constant.

Notice the REDUCER constant returns a lambda, but in order to use this constant one needs
to call the underlying lambda.

This is what happens with the statement => reducer.call(0, (1..5).to_a, lambda { |x, y| x + y })

so when I call this reducer what is returned?  Notice the reducer has be called with 3 arguments:
acc is 0, arr is (1..5).to_a, and binary function is lambda { |x, y| x + y } so the call with these
arguments returns the reducer_aux.call(acc, arr) which can be called because acc and arr are
supplied as arguments to the inner lambda.

Notice the output since the reducer itself is called, it returns a call to reducer_aux, we see the stack trace beging
at line 29 which is the call to reducer_aux.call(acc, arr) with acc = 0 and arr = [1, 2, 3, 4, 5] as these were passed
in from the call to reducer

Now we note from here on, the reducer_aux lambda is being called until the arr is empty.

The first time through we have the following call reducer_aux.call(binary_function(acc, arr.first), arr.drop(1)) so the binary function
inputs are acc = 0 and arr.first = 1, it returns the value 0 + 1 = 1, so we have in essence reducer_aux(1, [1, 2, 3, 4, 5]) because
this was the first call to the lambda on line 29.

Note in the initial call on line 29 we enter the lambda with acc = 0 and arr = [1, 2, 3, 4, 5] but then we go right down to the else
branch and call again, with reducer_aux.call(binary_function(acc, arr.first), arr.drop(1)), by invoking the binary function again
this sets the acc value to 1 + 2 = 3 and now the array is [2, 3, 4, 5] due to arr.drop(1)

so the big question in my mind is how is the acc value remembered between iterations, it is remembered because both acc and arr
are block parameters to the lambda for reducer_aux that is reducer_aux = lambda do |acc, aux| thus the passed in value for
acc is set by the retrun value of the binary_function and this is remembered each time, as it is captured in the block parameter
acc.

We can see this in the puts statements for the values of acc and arr at the top of the lambda definition.
=end
