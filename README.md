# Rubytalks
[![Build Status](https://drone.fuckrf.cf/api/badges/k0va1/rubytalks.org/status.svg)](https://drone.fuckrf.cf/k0va1/rubytalks.org)

All Ruby talks in one place.

## Contributing

If you would like to contribute to the project please read the [CONTRIBUTING.md](https://github.com/saintprug/rubytalks.org/blob/master/CONTRIBUTING.md)

## Setup

You can setup project with Docker(preferred way) or manually.
First of all you need to clone the project:

```
git clone https://github.com/saintprug/rubytalks.org && cd rubytalks.org
```

### Docker

Prepare database for `development` and `test` environments:

```
docker-compose run web bundle i
docker-compose run web bundle exec hanami db prepare
docker-compose run web bundle exec rake seeds
HANAMI_ENV=test docker-compose run web bundle exec hanami db prepare
```

How to run tests:

```
HANAMI_ENV=test docker-compose run web bundle exec rspec
```

How to run the development console:

```
docker-compose run web bundle exec hanami c
```

How to run the development server:

```
docker-compose up hanami
```

### Manually

> You need to install Postgres and Redis for you operating system.

Install dependencies:

```
bundle install
```

Prepare database for `development` and `test` environments:

Change `DATABASE_URL` and `REDISTOGO_URL` in `.env.development` and `.env.test`.

Example:

`.env.development`
```
...
DATABASE_URL="postgresql://localhost/rubytalks_development"
REDISTOGO_URL="redis://localhost:6379"
...
```

`.env.test`
```
...
DATABASE_URL="postgresql://localhost/rubytalks_test"
REDISTOGO_URL="redis://localhost:6379"
...
```


```
bundle exec hanami db prepare
bundle exec rake seeds
HANAMI_ENV=test bundle exec hanami db prepare
```

How to run tests:

```
bundle exec rspec
```

How to run the development console:

```
bundle exec hanami c
```

How to run the development server:

```
docker-compose run web bundle exec hanami s
```

When you run the server the app will be available at http://localhost:2300

## Deploy

```
heroku container:login
heroku container:push web -a rubytalks-org
heroku container:release web -a rubytalks-org
```

Show logs: `heroku logs --tail -a rubytalks-org`
