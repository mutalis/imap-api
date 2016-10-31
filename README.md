# README

rails new contacts-api-demo --api -d postgresql

rails new tango-orchestras --api

bundle exec spring binstub --all


Migrations:

rails g migration enable_uuid_extension

rails g scaffold orchestra name start_date:datetime end_date:datetime

In order to create DB, the Role must be created first.
> createuser -U postgres -P -e -s orchestras

rake db:create

rails g scaffold email username quota:integer password

rails g serializer email


rails g migration AddDomainRefToEmails domain:references

class AddDomainRefToEmails < ActiveRecord::Migration[5.0]
  def change
    add_reference :emails, :domain, type: :uuid, index: { unique: true }
    add_foreign_key :emails, :domains, on_delete: :cascade
  end
end


rails g migration AddUsernameIndexToEmail

class AddUsernameIndexToEmail < ActiveRecord::Migration[5.0]
  def change
    add_index :emails, :username, unique: true
  end
end






Routes:

Para cuando se necesita separar los controllers del API de los de la Web App se usa namespaces:

Rails.application.routes.draw do
  namespace :api, path: '/', constraints: { subdomain: 'api' } do
    resources :users
  end
end


rails t -vfb test/integration/routes_test.rb





==========
CURL

Defaults to GET request:
curl http://api.example.com:3000/users

Query strings:
curl http://api.example.com:3000/users?search=musica



Para ver solo los Headers de la respuesta:

curl -I http://api.example.com:3000/users

curl -I http://api.example.com:3000/users/2



Para ver los Headers de respuesta y la respuesta juntas:

curl -i http://api.example.com:3000/emails/e85c2a8e-4cae-470e-875e-dd6023bf37cf


Send custom request headers with the -H option

curl -IH "Accept: application/json" http://api.example.com:3000/users



Ver el contenido en el formato seleccionado:

curl -H "Accept: application/json" http://api.example.com:3000/users

curl -H "Accept: application/xml" http://api.example.com:3000/users

curl -iH "Accept: application/json" http://api.example.com:3000/emails/



Agregar un registro con POST:

curl -i -X POST -H "Content-Type:application/json; charset=utf-8" -d '{"email": { "username": "ana", "quota": 200, "password": "pass" }}' http://api.example.com:3000/emails

curl -i -X POST -H "Content-Type:application/json; charset=utf-8" -d '{ "username": "lau", "quota": 200, "password": "pass" }' http://api.example.com:3000/emails

curl -H "Content-Type:application/json; charset=utf-8" -d '{"orchestra": {"name":"Anzo","start_date":"1950-07-14 20:10:15", "end_date":"2015-05-29 16:20:05"}}' http://localhost:3000/orchestras



Token based authentication:

curl -iH "Authorization: Token token=29468cdafbd0b1c8a2cb81ecd7a8e517" http://api.example.com:3000/v2/emails

Using fake token:
The client ask for JSON, then the response headers must include the header: Content-Type: application/json; charset=utf-8

curl -iH "Authorization: Token token=fake" -H "Accept: application/json" http://api.example.com:3000/v2/emails

curl -iH "Authorization: Token token=2dcc9c915c3a7ff5e2a7cbe0b132f453" http://api.example.com:3000/v2/emails/571e99ae-c28e-4e3e-be0c-171998e16bb8


curl -iH "Authorization: Token token=2dcc9c915c3a7ff5e2a7cbe0b132f453" -X POST -H "Content-Type:application/json; charset=utf-8" -d '{ "username": "lau", "quota": 200, "password": "12345678", "domain_id": "1229997f-2692-406c-b726-c64cf71beffa" }' http://api.example.com:3000/v2/emails

======

Listing Media Types:

Dentro de la consola:

rails c

>Mime::SET.map(&:to_s)



===== DB


> createuser -U postgres -P -e dancercity

SQL:
psql> CREATE ROLE dancercity PASSWORD 'md556767a496e1da3cd3564675e3791a130' NOSUPERUSER NOCREATEDB NOCREATEROLE INHERIT LOGIN;


New Role (dancercity) who can create new databases

> createuser -U postgres -P -e -d dancercity


New Role (dancercity) Superuser

> createuser -U postgres -P -e -s dancercity



> createdb -U postgres -e -O dancercity -E UTF8 -T template0 --lc-collate=en_US.UTF-8 --lc-ctype=en_US.UTF-8 dancercity
SQL:
psql> CREATE DATABASE dancercity OWNER dancercity ENCODING 'UTF8' TEMPLATE template0 LC_COLLATE 'en_US.UTF-8' LC_CTYPE 'en_US.UTF-8';


>dropuser -U postgres dancercity

>dropdb -U postgres dancercity


Loads Factories (sample data) into the current environment's database:
rake dev:loads_factories

=====
Documentation:

To annotate just your models, tests, and factories:

annotate --exclude fixtures

To annotate just your models:

annotate --exclude tests,fixtures,factories,serializers

To annotate routes.rb:

annotate --routes

To automatically annotate every time you run db:migrate, either run rails g annotate:install or add Annotate.load_tasks to your `Rakefile`.
