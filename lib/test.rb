require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

account_sid = 
auth_token = 
 
client = Twilio::REST::Client.new account_sid, auth_token
 
from = "+16466795828" 
 
get '/send_to' do
	num = "+" + params[:num]
	name = params[:name]
	client.account.messages.create(
		:from => from, 
		:to => num,
		:body => "Hi #{name}, we would like to tell you about our promotional offer on widgets. Please reply 'Accept' to have our consultant call you."
	) 
	"Sent message to #{name}"
end

get '/sms-response' do
	twiml = Twilio::TwiML::Response.new do |r|
		num = params[:From]
		if  params[:Body] == "Accept"
			r.Message "Thanks for your response. Our representative will be calling you shortly."
			call = client.account.calls.create(
				:from => from,   
				:to => num, 
				:url => 'http://twimlets.com/forward?PhoneNumber=+19567664445&FailUrl=http://myapp.com/please-try-later.mp3'
			)
		else
		# Do not call customer, send message body and subscriber CLID to invalid response bucket
		end
	end
	twiml.text
end

