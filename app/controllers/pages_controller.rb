# Encoding: utf-8
class PagesController < ApplicationController
  inherit_resources
  actions :show

  def index
    @banners = Banner.visible
    @nursery = Page.where(category_id: Category.where(name: "Berçário e Minimaternal")).first
    @maternal = Page.where(category_id: Category.where(name: "Maternal")).first
    @garden = Page.where(category_id: Category.where(name: "Jardim")).first
    @tour = Page.where(category_id: Category.where(name: "Faça um tour virtual")).first
    @visit = Page.where(category_id: Category.where(name: "Visite a Baby House")).first
    @enroll = Page.where(category_id: Category.where(name: "Matricule seu filho")).first
  end
end
