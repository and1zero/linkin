# Linkin

[![Build Status](https://travis-ci.org/and1zero/linkin.svg?branch=master)](https://travis-ci.org/and1zero/linkin)

A generic URL shortener project.

The initial business requirements are:
* The link shortener should be able to receive a URL and give back a shortened URL.
* When a user accesses the shortened URL he should be redirected to the full URL.
* It should have an API endpoint where you can query stats around a particular shortened URL giving you details about the users that have visited the URL with as much information as you can get on that person.

## Demo

This project is deployed in 📦 [Heroku](https://www.heroku.com/): https://hanami-linkin.herokuapp.com/

### Disclaimer

The entire project actually defeats the purpose of shortening URL, because the generated URLs can be longer than the URL that we want to shorten. 😂

Example:

If we shorten `https://google.com` (18 chars), it will become `https://hanami-linkin.herokuapp.com/my/b` (~40 chars, the last encoded letter is random, depending on the primary key of the URL).

Also we are using the namespace `my` to shorten the URL. The purpose of this is to avoid situation where the generated encoded letters are similar to our routes, e.g. `urls`.

Of course, in the real world, we would have used different domain, preferable much shorter and we can use a custom WebMatcher.

## Dependencies

This project is built on Hanami.
* 💎 [Ruby](https://www.ruby-lang.org/en/) 2.4.2
* 🌸 [Hanami](http://hanamirb.org/) 1.1.0
* 🐘 [PostgreSQL](https://www.postgresql.org/)

## API Documentation

Please visit README.md inside `apps/api` to see the documentation for API.

## Project Setup

Assuming that user already have Ruby and PostgreSQL, we can simply install the application by:

```
% bundle install
```

How to run tests:

```
% bundle exec rake
```

How to run the development console:

```
% bundle exec hanami console
```

How to run the development server:

```
% bundle exec hanami server --port 4555
```

How to prepare (create and migrate) DB for `development` and `test` environments:

```
% bundle exec hanami db prepare

% HANAMI_ENV=test bundle exec hanami db prepare
```

## Using Docker and Docker-compose

If you have Docker and Docker compose installed, it is possible to install the entire project without having to install Ruby and PostgreSQL.

Simply build the containers:

```
% docker-compose build
```

And run it:

```
% docker-compose up -d
```

Create the database and apply migration:

```
% docker exec <web_container_id> hanami db prepare
```

And presto, it should be up and running in http://localhost:4555

### Running hanami commands in docker

Note: The web container instance must be up and running (from docker-compose).
If you cloned this repository under `linkin` folder, `<web_container_id>` can be aliased to `linkin_web_1`.

Simply append `docker exec <web_container_id>` before running any command

Migrating in docker:

```
% docker exec <web_container_id> hanami db migrate
```

Running tests in docker:

```
% docker exec <web_container_id> bundle exec rake
```

### Caveat

The first time we are installing and building these containers, we will see an error in the browser: `Sequel::DatabaseError: PG::UndefinedTable` because the database setup hasn't been done.
In order to do that, we need to execute `db prepare` command inside the web container.

```
% docker exec <web_container_id> bundle exec hanami db prepare
```

## ROADMAP

Several improvements can be done to this app.

- [ ] Write more scalable query for fetching stats. Currently everything is handled in Javascript, but aggregation and time range filter should happen on server side.
- [ ] We can add authentication and scope each shortened URLs by user.
- [ ] We can integrate Webpack to this project to have rich experience in frontend development.
- [ ] We can integrate a worker to convert request IP address and user agent to more useful informations, most likely the geo location data and OS/browser information.
