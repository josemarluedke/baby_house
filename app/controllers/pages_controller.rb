# Encoding: utf-8
class PagesController < ApplicationController
  inherit_resources
  actions :show

  def index
     @nursery = Page.where(category_id: Category.where(name: "Berçário e Minimaternal")).first rescue Page.new
     @maternal = Page.where(category_id: Category.where(name: "Maternal")).first rescue Page.new
     @garden = Page.where(category_id: Category.where(name: "Jardim")).first rescue Page.new
     @tour = Page.where(category_id: Category.where(name: "Faça um tour virtual")).first rescue Page.new
     @visit = Page.where(category_id: Category.where(name: "Visite a Baby House")).first rescue Page.new
     @enroll = Page.where(category_id: Category.where(name: "Matricule seu filho")).first rescue Page.new
  end
end
