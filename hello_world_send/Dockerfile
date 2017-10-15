FROM ruby:2.4
COPY Gemfile /
COPY send.rb /
RUN bundle install
CMD ruby send.rb