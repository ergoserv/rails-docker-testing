FROM ruby:2.6.3

ENV APP_HOME /home/myappx

# Container Setup
RUN mkdir -p /home/docker
COPY .docker/*.sh /home/docker/
RUN chmod +x /home/docker/*.sh
RUN /home/docker/setup.sh
ENTRYPOINT ["/home/docker/docker-entrypoint.sh"]
EXPOSE 3000

# Appplication Setup
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile Gemfile.lock $APP_HOME/
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
RUN bundle install
COPY . $APP_HOME

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
