# Founden

Founden is an experimental online communication and collaboration application.

Email, Chat (HipChat, Slack) and Google Wave served as the inspiration for us
in building a modern and efficient technology while addressing [current
email/messaging problems](http://en.wikipedia.org/wiki/E-mail#Problems).

![Founden v4](https://s3.amazonaws.com/screenshots.angel.co/d4/280048/ddff3a1d18b55b27c2cb36be44f0705d-original.png)

Founden was closed after ~4 months and after failing to raise investments for
further development.

[Read the full story](http://ampersate.com/the-last-7-months-of-our-venture).
[A little outdated static demo](http://proto.doersapp.com.s3.amazonaws.com/index.html).

## Installation

Founden is written in Ruby using Rails and Ember.js.

You will need a PostgreSQL database, ideally with many connections allowed due
to websocket communication between the client and the server.

### Ruby version

We suggest using `rbenv` and `rbenv-install` in order to get Ruby install.

Install the latest stable Ruby version (MRI) available.

### Configuration

Make sure you create a copy of every file in the `config` folder with the
`.example` extension, leaving it out.

You can exclude: `aws.yml` and `bugsnag.yml`.
Those are using only in production.

### System dependencies

Run `bundle install` to install dependencies.

## Development

You can run `bundle exec rake db:create db:migrate`to set up the databse.

Run `bundle exec rails server` and point your browser to `http://lvh.me:3000`.

### Tests

Use RSpec to test models and controllers.
Use Capybara for integration testing.

Run `bundle exec rake` to run the tests.
You can also use Guard to run tests while writing them. Use `bundle exec guard`.

## Deployment

Capistrano is used for deployments.

Please keep `config/deploy.rb` clean, by adding only hooks in there.
Add additional tasks/extensions to `lib/capistrano/`.

To deploy latest version, run `bundle exec cap production deploy`.

To get a remote console, run `bundle exec cap rails:console`.

To restart the app, run `bundle exec cap puma:restart`.
