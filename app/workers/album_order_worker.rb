class AlbumOrderWorker
  include Sidekiq::Worker

  sidekiq_options :retry => 3

  def perform(id)
    album = AlbumOrder.find(id)
    album.purchase
  end
end
