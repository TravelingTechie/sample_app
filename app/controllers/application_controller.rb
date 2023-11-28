class ApplicationController < ActionController::Base
    def hello
     render html: "hello, world - test deployment is pushing up all code"
    end 
 end
 