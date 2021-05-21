FROM ruby:2.6.3

RUN apt-get update -qq && apt-get install -y build-essential

RUN apt-get install -y nodejs

RUN mkdir /usr/app
WORKDIR /usr/app

COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

COPY . .

RUN bin/rails db:schema:load
RUN bin/rails db:migrate

CMD ["bin/rails","server","-p","3000","-b","0.0.0.0"]
