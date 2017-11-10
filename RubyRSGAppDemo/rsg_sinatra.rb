require 'sinatra'
require 'sinatra/reloader' if development?
require './rsg.rb'

#Ruby RSG Webapp Assignment
#WEIWEI SU
#U17420699
#rsg_sinatra.rb

get '/' do
  erb :rsg_page
end

post '/' do
  #Read File name from browser
  @fileName = params[:fileName]

  #Do input validation
  if /^[a-zA-Z\-]+$/.match(@fileName) #So the filename can only be contain characters(Case insensitive) and '-'.
    begin
      #I need to bring up some original codes from original read_grammar_defs function since from here it won't call the Exception.
      @fileName = 'grammars/' + @fileName unless @fileName.start_with? 'grammars/'
      @fileName += '.g' unless @fileName.end_with? '.g'
      open(@fileName, 'r') { |f| f.read }
      #Starting Generation Process
      rsg(@fileName)
      @Output = @sentence.join(' ')
    rescue
      @Output = 'No such file in Directory'
    end
  else
    @Output='File Name does not need to include extension, nor File Name have numbers.'
  end

  erb :rsg_page, :locals => {'fileName' => @Output}
end


