FROM ruby:2.6.3

# Install common dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

# Install Yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version 1.19.1 && \
  ln -sf $HOME/.yarn/bin/yarn /usr/local/bin/yarn && \
  ln -sf $HOME/.yarn/bin/yarnpkg /usr/local/bin/yarnpkg

WORKDIR /tmp
COPY package.json /tmp/
RUN yarn install

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
