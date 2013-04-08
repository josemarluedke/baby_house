# Encoding: utf-8
class TalkForm < MailForm::Base
  attribute :name, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :phone
  attribute :message, validate: true

  def headers
    {
      :subject => "Solicitação de palestra ou curso pelo site Baby House",
      :to => ["gustavo@tridara.net"]
    }
  end
end
