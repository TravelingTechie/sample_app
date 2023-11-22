class ApplicationController < ActionController::Base
    def hello
     render html: "hello, world - test test test"
    end 
 end
 