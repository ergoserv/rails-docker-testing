FROM ruby:2.6.3

ARG app_name

ENV APP_HOME /home/$app_name
ENV DOCKER_HOME /home/docker

# Container Setup
RUN mkdir -p $DOCKER_HOME/bin
COPY ./docker/bin/*.sh $DOCKER_HOME/bin/
RUN chmod +x $DOCKER_HOME/bin/*.sh
RUN $DOCKER_HOME/bin/setup.sh
ENTRYPOINT ["$DOCKER_HOME/bin/docker-entrypoint.sh"]
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
