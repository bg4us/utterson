require 'moneta'
require 'uuid'
require 'pony'

configure :development do
  set :base_url, 'http://127.0.0.1:5000'
  app_cache = Moneta.new(:File, dir: 'app_cache')
  set :app_cache, app_cache

  signup_cache = Moneta.new(:File, dir: 'signup_cache')
  set :signup_cache, signup_cache

  set email_options, {      
    :via => :sendmail
  }
end

configure :production do
  set :base_url, 'http://utterson.herokuapp.com'
  app_cache = Moneta.new(:File, dir: 'app_cache')
  set :app_cache, app_cache

  signup_cache = Moneta.new(:File, dir: 'signup_cache')
  set :signup_cache, signup_cache

  set email_options, {      
    :via => :smtp,
    :via_options => {
      :address => 'smtp.sendgrid.net',
      :port => '587',
      :domain => 'heroku.com',
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :authentication => :plain,
      :enable_starttls_auto => true
    }
  }
end

get '/' do
  erb :index
end

get '/test' do
  erb :test
end

# The signup email will get a something like {'token':'060fdc20-411a-0132-6866-38e856374b1e'}
post '/setup/:email' do
  content_type :json
  email = params[:email]
  halt 400 if !email

  uuid = UUID.new
  authkey = uuid.generate
  settings.signup_cache[email] = authkey
  Pony.options = settings.email_options
  Pony.mail(:to => email, 
          :from => 'utterson@bg4us.com', 
          :subject => 'Confirm your email', 
          :body => "Please visit #{base_url}/confirm/#{email}/#{authkey} to get your app token")
  status 202
end

get '/confirm/:email/:authkey' do
  email = params[:email]  
  authkey = params[:authkey]

  # Fail if no parameters
  halt 400 if !email || !authkey

  # Fail if the signup token is not found
  halt 400 unless settings.signup_cache.key?(email)
  
  halt 404 if authkey != settings.signup_cache[email]

  # All good, generate an app id and return it
  uuid = UUID.new
  appid = uuid.generate
  settings.app_cache[appid] = email
  [201, "{'token':'#{appid}'}"]
end

post '/send/:appid' do
  appid = params[:appid]
  halt 400 unless appid

  halt 404 unless settings.app_cache.key?(appid)

  sender = settings.app_cache[appid]

  name = params[:name]
  email = params[:email]
  message = params[:message]

  # Fail if no parameters
  halt 400 if !email || !name || !message

  Pony.options = settings.email_options
  Pony.mail(:to => email, 
            :from => sender, 
            :subject => 'New Message', 
            :body => "Name:\t#{name}\rEmail:\t#{email}\rMessage\r#{message}")
end

