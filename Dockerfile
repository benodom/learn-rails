# Dockerfile
FROM quay.io/aptible/ruby:2.4-ubuntu-16.04

RUN apt-get update && apt-get -y install build-essential

# libpq-dev is required
RUN apt-get update && apt-get -y install libpq-dev

RUN apt-get update && apt-get -y install libsqlite3-dev


# Add Gemfile before rest of repo, for Docker caching purposes
# See http://ilikestuffblog.com/2014/01/06/
ADD Gemfile /app/
ADD Gemfile.lock /app/
WORKDIR /app
RUN bundle install

ADD . /app
RUN bundle exec rake assets:precompile

ENV PORT 3000
EXPOSE 3000