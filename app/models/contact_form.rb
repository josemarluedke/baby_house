class ContactForm < MailForm::Base
  attribute :subject
  attribute :name, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :phone
  attribute :message, validate: true

  def headers
    {
      :subject => "Contato pelo site Baby House",
      :to => "josemarluedke@gmail.com"
      #:to => "gustavo@tridara.net"
    }
  end
end
