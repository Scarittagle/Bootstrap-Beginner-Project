require 'sinatra'
require 'mysql2'
require 'json'

#Take-Home-Final
#WEIWEI SU
#U17420699
#main.rb


#Connect to the Database
client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "sert", :database => "namelist")
results = client.query("SELECT * FROM babynames", :as => hash) #query it to get names and data

#Load up the webpage
get '/' do
  erb :display
end

#I followed and modified some code from Dr.V's AJAX Demo
get '/display' do
  if params['text']
    results.each do |row|
      if row.has_value?(params['text'])
        @value = row.values
        #Before returning there're some values need to be convert
        @value.map!{|x| x == 0 ? 1001 : x}.flatten!
        #Pop last element since is useless
        @value.pop
      else
        #Returning Error message if not found
        {:result => "Name not found"}.to_json
      end
    end
    #Return JSON
    content_type :json
    #Returning Array of Specific data back to erb
    {:result => @value}.to_json
  else
    halt(404)
  end
end
