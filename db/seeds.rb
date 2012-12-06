# Encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

AdminUser.create! email: "admin@example.com", password: "password", password_confirmation: "password"

about = Category.create name: "Sobre a Baby House"
pedagogy= Category.create name: "Pedagogia para a vida"
portal = Category.create name: "Portal das famílias"
home = Category.create name: "Quem é a Baby House?"
nursery = Category.create name: "Berçário e Minimaternal"
maternal = Category.create name: "Maternal"
garden = Category.create name: "Jardim"
tour = Category.create name: "Faça um tour virtual"
visit = Category.create name: "Visite a Baby House"
enroll = Category.create name: "Matricule seu filho"

Page.create title: about.name, body: "Text", category: about
Page.create title: pedagogy.name, body: "Text", category: pedagogy
Page.create title: home.name, body: "Text", category: home
Page.create title: nursery.name, body: "Text", category: nursery
Page.create title: maternal.name, body: "Text", category: maternal
Page.create title: garden.name, body: "Text", category: garden
Page.create title: tour.name, body: "Text", category: tour
Page.create title: visit.name, body: "Text", category: visit
Page.create title: enroll.name, body: "Text", category: enroll
