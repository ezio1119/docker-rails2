FROM ruby:2.6.3-alpine3.10 AS builder

RUN apk add --no-cache alpine-sdk \
    nodejs-current \
    nodejs-npm \
    yarn \
    mysql-client \
    mysql-dev \
    python2 \
    tzdata

ENV APP_ROOT /usr/src/app
WORKDIR $APP_ROOT

COPY Gemfile $APP_ROOT
COPY Gemfile.lock $APP_ROOT

RUN bundle install


FROM ruby:2.6.3-alpine3.10

RUN apk add --no-cache alpine-sdk \
    nodejs-current \
    nodejs-npm \
    yarn \
    mysql-client \
    mysql-dev \
    python2 \
    tzdata

COPY --from=builder /usr/local/bundle /usr/local/bundle

ENV APP_ROOT /usr/src/app
WORKDIR $APP_ROOT