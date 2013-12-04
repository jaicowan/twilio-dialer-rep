require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

account_sid = 'AC49852d6f8f92a73cc6d9192ad5cd29e6'
auth_token = '9a64bc17c6565c421cb0893b0ec99342'
 
client = Twilio::REST::Client.new account_sid, auth_token
 
from = "+16466795828" 
 
get '/send_to' do
	num = "+" + params[:num]
	name = params[:name]
	client.account.messages.create(
		:from => from, 
		:to => num,
		:body => "Hi #{name}, we would like to tell you about our promotional offer on widgets. Please reply 'accept' to have our consultant call you."
	) 
	puts "Sent message to #{name}"
end

get '/sms-response' do
	twiml = Twilio::TwiML::Response.new do |r|
		if  params[:Body] == "Accept"
			(
			r.Message "Thanks for your response. Our representative will be calling you shortly."
			call = client.account.calls.create(
				:from => from,   
				:to => "+61299598017", 
				:url => 'http://twimlets.com/forward?PhoneNumber=+14083313300&FailUrl=http://myapp.com/please-try-later.mp3'
			)
			)
		else
		# Do not call customer, send message body and subscriber CLID to invalid response bucket
		end
	end
	twiml.text
end

