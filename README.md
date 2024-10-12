# Linkin

A generic URL shortener project.

The initial business requirements are:
* The link shortener should be able to receive a URL and give back a shortened URL.
* When a user accesses the shortened URL he should be redirected to the full URL.
* It should have an API endpoint where you can query stats around a particular shortened URL giving you details about the users that have visited the URL with as much information as you can get on that person.

## Dependencies

This project is built on Rails.
* 💎 [Ruby](https://www.ruby-lang.org/en/)
* 🛤️ [Rails](hhttps://guides.rubyonrails.org/)

Alternatively, we can use 🐋 `docker` and 🐳 `docker-compose`.

## Project Setup

Assuming that user already have Ruby, we can simply install the application by:

```shell
$ bundle install
```

How to run tests:

```shell
$ rails db:test:prepare
$ rails test
```

How to run the development console:

```shell
$ rails c
```

How to run the development server:

```shell
$ rails s
```

How to prepare (create and migrate) DB:

```shell
$ rails db:migrate
```
