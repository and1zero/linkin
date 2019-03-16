FROM ruby:2.5.3

# install libraries
RUN apt-get update && \
    apt-get install -y build-essential libpq-dev postgresql-client cron \
    --fix-missing --no-install-recommends

ENV APP_HOME /app

RUN mkdir -p $APP_HOME

WORKDIR $APP_HOME

# cleanup
RUN rm -rf /var/lib/apt/lists/*

COPY . $APP_HOME

# this is the default environment if no build-arg is passed
ARG environment=production
ENV HANAMI_ENV $environment
ENV HANAMI_HOST=0.0.0.0

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

RUN bundle install

EXPOSE 2300
CMD ["hanami server"]
