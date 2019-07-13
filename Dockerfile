FROM ruby:2.5

ENV APP_HOME /home/myappx

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client zsh
RUN sh -c "$(wget -O- https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN mkdir -p $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile /$APP_HOME/Gemfile
COPY Gemfile.lock /$APP_HOME/Gemfile.lock
RUN bundle install
COPY . /$APP_HOME

# Add a script to be executed every time the container starts.
RUN mkdir -p /home/docker
COPY .docker/entrypoint.sh /home/docker/
RUN chmod +x /home/docker/entrypoint.sh
ENTRYPOINT ["/home/docker/entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
