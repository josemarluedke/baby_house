# Encoding: utf-8
class InformationForm < MailForm::Base
  attribute :name, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :phone, validate: /\(?([0-9]{2||3})\)?[-. ]?([0-9]{4})[-. ]?([0-9]{4})/
  attribute :message, validate: true

  def headers
    {
      :subject => "Solicitação de mais informações pelo site Baby House",
      :to => ["gustavo@tridara.net", "contato@escolababyhouse.com"]
    }
  end
end

