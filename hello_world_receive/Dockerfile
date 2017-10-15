FROM ruby:2.4
COPY Gemfile /
COPY receive.rb /
RUN bundle install
CMD ruby receive.rb