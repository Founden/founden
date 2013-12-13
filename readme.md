# Founden

This project has no name yet.

## Ruby version

We suggest using `rbenv` and `rbenv-install` in order to get Ruby install.

Install the latest stable Ruby version (MRI) available.

## Configuration

Make sure you create a copy of every file in the `config` folder with the
`.example` extension, leaving it out.

You can exclude: `aws.yml` and `bugsnag.yml`.
Those are using only in production.

## System dependencies

Run `bundle install` to install dependencies.

## Development

You can run `bundle exec rake db:create db:migrate`to set up the databse.

Run `bundle exec rails server` and point your browser to `http://lvh.me:3000`.

## Tests

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
