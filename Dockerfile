FROM ruby:2.6.3

RUN apt-get update && apt-get install --assume-yes postgresql postgresql-client
RUN apt-get install git

RUN bundle config --global frozen 1

RUN mkdir /app
WORKDIR /app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN gem install bundler:2.1.2
RUN bundle install --without development test -j 5

ADD . /app

ENV LANG=en_US.UTF-8
ENV HANAMI_ENV=production

EXPOSE 2300

CMD /app/startup.sh
