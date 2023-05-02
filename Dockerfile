FROM ruby:2.7-alpine

WORKDIR /app

RUN gem install sinatra

COPY . .

EXPOSE 3500

CMD ["./server.rb", "-p", "3500", "-e", "production"]
