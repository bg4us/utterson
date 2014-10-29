![Utterson image](http://raw.githubusercontent.com/bg4us/utterson/master/public/img/utterson.png)

Utterson - contact form processing
----------------------------------

This is an open source tool for static sites (Jekyll, etc.) where you want 
to have a simple contact form that will be forwarded to your email.

We developed this for our own sites, and you are welcome to use our running
instance in heroku by registering (please don't abuse it).

You can inspect the code on github.  We promise, we are not going to spam you, 
use the email addresses you collect, or do anything evil.  Inspect the code on 
github, or if you still feel uneasy about using our server, create a free Heroku 
account and roll your own.

Usage
-----

Register your email:

```bash
    $ curl --data "email=<your_email>" https://utterson.herokuapp.com/setup    
```

You should receive an email asking you to confirm your address.  Click/visit on the link
on that email, and you will be taken to a page that will give you your `apptoken`, which
is what you will use on your webpage, and the curl commands where `<apptoken>` appears.

Test (optional):

```bash
    $ curl --data "email=visitor@form.com&name=visitor&message=hello" \
           https://utterson.herokuapp.com/user/<apptoken>
```

Put it into action on your own page:

```html
<form action="https://utterson.herokuapp.com/send/<apptoken>">
  Email: <input type="text" name="name"><br>
  Name: <input type="text" name="email"><br>
  Message: <textarea name="message" cols="40" rows="5"></textarea>
  <input type="submit" value="Send Message">
</form> 
```

The required parameters are: `email`, `name` and `message`. Other parameters will be ignored.


Privacy concerns?
-----------------

Deploy to [Heroku](http://www.heroku.com) by clicking this button.

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

Add the SendGrid Add on, or use any other mail solution and customize

```
heroku addons:add sendgrid
```

Are you more of a command line person?

A [SendGrid](http://sendgrid.com) account required for email delivery.

```bash
    $ git clone https://github.com/bg4us/utterson.git
    $ heroku create
    $ heroku config:set SENDGRID_API_KEY=<KEY>
    $ heroku addons:add heroku-postgresql:dev
    $ heroku pg:promote HEROKU_POSTGRESQL_COLOR
    $ heroku ps:scale web=1
```


Running it locally for development
----------------------------------

```
$ git clone https://github.com/bg4us/utterson.git
$ gem install bundler
$ bundle
$ bundle exec foreman start
```

Navigate to localhost:5000

When running locally, utterson will use your local file system to store the key
pairs, and will try using sendmail on your local machine to send messa

