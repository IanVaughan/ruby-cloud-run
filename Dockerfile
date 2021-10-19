FROM ruby:2.7

WORKDIR /app
COPY . .
RUN gem install --no-document bundler \
    && bundle config --local frozen true \
    && bundle config --local without "development test" \
    && bundle install

ENTRYPOINT ["bundle", "exec", "functions-framework", "--target=hello"]
