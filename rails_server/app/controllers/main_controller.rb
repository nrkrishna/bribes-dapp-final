require 'uri'
class MainController < ApplicationController
    def index
        if session[:bribe] != nil
            @bribe = session[:bribe]
            session[:bribe] = nil
        else
            @bribe = nil
        end
    end

    def create
        date = params[:bribedetails][:date]
        amount = params[:bribedetails][:amount]
        details = params[:bribedetails][:details]

        if date == nil || date.length == 0 || amount == nil || amount.length == 0 || details == nil || details.length == 0
            return
        end

        session[:bribe] = date + " " + URI::encode(amount) + " " + URI::encode(details)
        puts session[:bribe]

        #flash[:success] = "Bribe successfully submitted"
        redirect_to  :action => "index"
    end
end
