# README

# Nextie Unicorn App
An app to mange happiness of the team unicorns !

## Dependencies
- Ruby 2.6
- @vue/cli
- PostgreSQL

## Install
go in nextie-backend folder and run :
`bundle install`
after that run :
`rails db:create db:migrate db:seed`

then go in nextie-backend/nextie-frontend folder and run :
`yarn install`

## Launch server
run command `rails s`
run command `yarn dev` 

and visit the app on url : http://localhost:8080

__Login as:__

to see the app as **admin**, manage unicorns, and attribute unicorn to collaborator : 
email   = admin@gmail.com  
passwor = secret

to see the app as **collab**, and ask for a unicorn, or change name of it :

- To ask for a unicorn
email    = stef@gmail.com
password = secret

- To update the name of your unicorn
email    = lea@gmail.com
password = secret
