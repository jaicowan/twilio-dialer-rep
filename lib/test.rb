require 'rubygems'
require 'twilio-ruby'
require 'sinatra'

# put your own credentials here - from twilio.com/user/account
account_sid = 'AC49852d6f8f92a73cc6d9192ad5cd29e6'
auth_token = '9a64bc17c6565c421cb0893b0ec99342'
 
# set up a client to talk to the Twilio REST API
client = Twilio::REST::Client.new account_sid, auth_token
 
from = "+16466795828" # Your Twilio number
 
friends = {
"+6584286950" => "SG Mobile"
#,"+14155557775" => "Boots",
#"+14155551234" => "Virgil"
}
get '/send' do
	friends.each do |key, value|
	client.account.messages.create(
	:from => from,
	:to => key,
	:body => "Hey #{value}, Monkey party at 6PM. Bring Bananas!"
	) 
	"Sent message to #{value}"
	end
end
get '/sms-quickstart' do
    twiml = Twilio::TwiML::Response.new do |r|
		if  params[:Body] == "accept"
			(r.Message "Thanks for your response. Our agent will be calling you shortly."
			call = client.account.calls.create(
			:from => '+16466795828',   # From your Twilio number
			:to => '+61299598017',     # To any number
			# Fetch instructions from this URL when the call connects
			:url => 'http://twimlets.com/forward?PhoneNumber=+61299598017&FailUrl=http://myapp.com/please-try-later.mp3'
			)
			)
		else
		# Do not call
	end
	twiml.text
end

