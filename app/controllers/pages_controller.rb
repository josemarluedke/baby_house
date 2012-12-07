# Encoding: utf-8
class PagesController < ApplicationController
  inherit_resources
  actions :show

  def index
    @banners = Banner.visible
    @home = Page.where(category_id: Category.where(name: "Quem é a Baby House?")).first
    @nursery = Page.where(category_id: Category.where(name: "Berçário e Minimaternal")).first
    @maternal = Page.where(category_id: Category.where(name: "Maternal")).first
    @garden = Page.where(category_id: Category.where(name: "Jardim")).first
    @tour = Page.where(category_id: Category.where(name: "Faça um tour virtual")).first
    @visit = Page.where(category_id: Category.where(name: "Visite a Baby House")).first
    @enroll = Page.where(category_id: Category.where(name: "Matricule seu filho")).first
    feed = Blog.fetch_last_posts
    @entries = feed.entries.first(3)
  end
end
