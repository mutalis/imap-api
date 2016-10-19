# README

rails new contacts-api-demo --api -d postgresql

rails new tango-orchestras --api

bundle exec spring binstub --all

rails g migration enable_uuid_extension

rails g scaffold orchestra name start_date:datetime end_date:datetime

> createuser -U postgres -P -e -s orchestras

rake db:create


Rails.application.routes.draw do
  namespace :api, path: '/', constraints: { subdomain: 'api' } do
    resources :users
  end
end

Defaults to GET request:
curl http://api.educativos.org:3000/users


Para ver los Headers de la respuesta:

curl -I http://api.educativos.org:3000/users

curl -I http://api.educativos.org:3000/users/2


Ver el contenido en el formato seleccionado:

curl -H "Accept: application/json" http://api.educativos.org:3000/users

curl -H "Accept: application/xml" http://api.educativos.org:3000/users


Send custom request headers with the -H option

curl -IH "Accept: application/json" http://api.educativos.org:3000/users



Agregar un registro con POST:

curl -H "Content-Type:application/json; charset=utf-8" -d '{"name":"rodolfo"}' http://api.educativos.org:3000/users


curl -H "Content-Type:application/json; charset=utf-8" -d '{"orchestra": {"name":"Anzo","start_date":"1950-07-14 20:10:15", "end_date":"2015-05-29 16:20:05"}}' http://localhost:3000/orchestras


Listing Media Types:
Dentro de la consola:
rails

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
