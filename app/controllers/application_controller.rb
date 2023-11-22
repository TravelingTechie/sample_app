class ApplicationController < ActionController::Base
    def hello
        render html: "hello, world.  This is the millionth time I've done this."
       end 
end
