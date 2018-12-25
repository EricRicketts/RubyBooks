module​ Redis
​     ​class​ Server
​       ​# ... more code ...​
​ 
​       ​def​ run
​         ​loop​ ​do​
​           session = @server.accept
​ 
​           ​begin​
​             ​return​ ​if​ ​yield​(session) == ​:exit​
​           ​ensure​
​             session.close
​           ​end​
​         ​end​
​       ​rescue​ => ex
​         $stderr.puts ​"Error running server: ​​#{​ex.message​}​​"​
​         $stderr.puts ex.backtrace
​       ​ensure​
​         @server.close
​       ​end​
​ 
​       ​# ... more code ...​
​     ​end​
​   ​end​

=begin
1.  Does Redis::Server#run require a block to be passed in?

Yes, as the yield keyword is used.  Since there is no block_given?
check, a LocalJumpError would result if no block was passed in.

2.  How is the return result of this block used?

If the return value from the block is :exit then #run exits.  Otherwise,
the session local variable is passed to the block.  Note that even though
the conditional is checking for an exit condition, yield(session) still means
a session is still beeing passed to an accompanying block.

3.  How could this code be called?

Redis::Server.new.run do |session|
  # do something with the session
end

The session return value is discarded unless it returns :exit
=end
