# Linkin

A generic URL shortener project.

The initial business requirements are:
* The link shortener should be able to receive a URL and give back a shortened URL.
* When a user accesses the shortened URL he should be redirected to the full URL.
* It should have an API endpoint where you can query stats around a particular shortened URL giving you details about the users that have visited the URL with as much information as you can get on that person.

## Demo

This project is deployed in heroku: https://hanami-linkin.herokuapp.com/

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
% docker-compose run
```

And presto, it should be up and running in http://localhost:4555

### Caveat

The first time we are installing and building these containers, e will see an error in the browser: `Sequel::DatabaseError: PG::UndefinedTable` because the database setup hasn't been done.
In order to do that, we need to execute `db prepare` command inside the web container.

```
% docker exec <web_container_id> bundle exec hanami db prepare
```

## ROADMAP

Several improvements can be done to this app.

- [ ] Write a more scalable query for fetching stats. Currently everything is handled in Javascript, but aggregation and time range filter should happen on the client side.
- [ ] We can add authentication and scope each shortened URLs by user.
- [ ] We can integrate Webpack to this project to have rich experience in frontend development.
