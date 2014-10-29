Utterson - contact form processing
----------------------------------

This is an open source tool for static sites (Jekyll, etc.) where you want 
to have a simple contact form that will be forwarded to your email.

We developed this for our own sites, and you are welcome to use our running
instance in heroku by registering.  You can inspect the code on github.  We
promise, we are not going to spam you, use the email addresses you collect,
or do anything evil.  Inspect the code on github, or if you still feel uneasy
about using our server, create a free Heroku account and roll your own.

Usage
-----



Privacy concerns?
-----------------

Deploy to [Heroku](http://www.heroku.com) by clicking this button.

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

Add the SendGrid Add on, or use any other mail solution and customize

```
heroku addons:add sendgrid
```

Are you more of a command line person?

A [Mandrill](http://mandrill.com) account required for email delivery.

```bash
    $ git clone https://github.com/theuav/fwdform.git
    $ heroku create
    $ heroku config:set MANDRILL_API_KEY=<KEY>
    $ heroku addons:add heroku-postgresql:dev
    $ heroku pg:promote HEROKU_POSTGRESQL_COLOR
    $ heroku ps:scale web=1
```


Running it locally
------------------

```
$ git clone git://github.com/scottmotte/sinatra-heroku-cedar-template.git
$ gem install bundler
$ bundle
$ bundle exec foreman start
```

Navigate to localhost:5000

