# Basecamp-clone

* Main branch: master
* Ruby version: "2.3.1"
* Rails version: "~> 4.2"
* PG version: ~> 0.17.1

## Installation / Getting Started

To install (development environment) on your machine, just follow the tips above:

    % git clone git@github.com:cosmitdev/basecamp-clone.git

After you have cloned this repo, run this setup script to set up your machine
with the necessary dependencies to run and test this app:

    % ./bin/setup

It assumes you have a machine equipped with Ruby, Postgres, etc. If not, set up
your machine with [this script].

[this script]: https://github.com/COSMITdev/env-setup

After setting up, you can run the application using [Heroku Local]:

    % heroku local

[Heroku Local]: https://devcenter.heroku.com/articles/heroku-local

## Running Specs

We use [Capybara Webkit](https://github.com/thoughtbot/capybara-webkit) for
full-stack JavaScript integration testing. It requires QT. Instructions for
installing QT are [here](https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit).

* **Create Test DB and run migrations**

```bin/rake db:create db:migrate RAILS_ENV=test```

* **Run Specs**

```bundle exec rspec .```

## Creating feature branches

In all projects we work with `feature branches`. It's a good way to controll who are doing what and to improve quality of code, once you need to up a PR with that branch after.

### Create the branch

The nomenclature of the feature branch is composite by `{name initials}-{feature name || description}`, and probably will be something like that: `pm-review-typo` or `pm-create-users`.

Also, always keep you branch up-to-date with master, and keep master updated too. To do this, always run `git checkout master && git pull origin master`

Now, to create the feature branch just run `git checkout master && git checkout -b
[name-of-branch]`.

## Openning a Pull Request

After you finish the implementations what you did on your branch, you can up this to Github and open a Pull Request. This way other persons of the project can available your things and propose improvements. Just create the PR when you have confidence you create everything you need to, like views, controllers, specs...

## Finishing/Delivering/Updating Trello

For now we are using Trello to organize the features and sprints of the project, so, just delivery a task when you finish this and up the PR. Anyone can update cards on Trello, so be confident to do it yourself when you feel that your feature is ready to launch.
https://trello.com/b/r1MEFAOq/basecamp-killer
