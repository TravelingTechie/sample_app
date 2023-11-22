class ApplicationController < ActionController::Base
    def hello
     render html: "hello, world - finally working in prod"
    end 
 end
 