FROM ruby:2.6.3

ARG app_name

ENV APP_HOME /home/$app_name

# Container setup
RUN mkdir -p /home/docker/bin
COPY ./docker/bin/*.sh /home/docker/bin/
RUN chmod +x /home/docker/bin/*.sh
RUN /home/docker/bin/setup.sh

# Appplication setup
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile Gemfile.lock $APP_HOME/
# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1
RUN bundle install
COPY . $APP_HOME
ENTRYPOINT ["/home/docker/bin/entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
