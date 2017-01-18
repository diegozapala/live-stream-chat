# Live Stream Chat

The Live Stream Chat is accessible in the URL::

    https://live-stream-chat.herokuapp.com/

Or in your local environment following the instructions:

## Requirements

* ruby 2.4.0 or higher;
* Rails 5.0.1 or higher;
* PostgreSQL 9.5.5 or higher;
* Redis 3.2 or higher;

## Installation

First execute:

    $ bundle install

And then execute:

    $ rake db:create db:migrate: db:seed

## How to run

Execute:

    $ rails s

Start the redis server:

    $ redis-server

Then in the browser run:

    localhost:3000

Sign in with:

  * For admin user

      email: teste_admin@teste.com.br, password: testes

  * For common user

      email: teste1@teste.com.br, password: testes

## Usage

Use the chat:

  1 - Choose a live stream

  2 - Write in the text box

  3 - Click the button

      "Enviar"

Generate report:

  1 - Sign in with admin user
  2 - Choose a live stream
  3 - Click the link

      "Encerrar Live Stream"

  * All reports can be accessed in menu bar in the link

      "Relatórios"

Generate daily awards:

  1 - Start "sidekiq":

      $ sidekiq

  2 - Enter in rails console:

      $ rails c

  3 - Call "worker":

      GenerateDailyAwardWorker.perform_async()
