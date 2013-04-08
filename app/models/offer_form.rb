# Encoding: utf-8
class OfferForm < MailForm::Base
  attribute :sector, validate: true
  attribute :name, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :phone
  attribute :message, validate: true
  attribute :file, attachment: true, validate: :validate_file

  def validate_file
    unless file.present?
      return true
    end

    unless file.original_filename.match(%r{\.(png|jpg|jpeg|doc|docx|pdf|pps|ppsx)$}i)
      self.errors.add(:file, "Extensão inválida")
    end
  end

  def headers
    {
      :subject => "Solicitação de mais informações pelo site Baby House",
      :to => emails[sector]
    }
  end

  private
  def emails
    {
      1 => ["gerenteescolababyhouse.com"],
      2 => ["saude@escolababyhouse.com", "gerente@escolababyhouse.com"],
      3 => ["administrativo@escolababyhouse.com"],
      4 => ["pedagogico@escolababyhouse.com"],
      5 => ["direcao@escolababyhouse.com"],
      6 => ["direcao@escolababyhouse.com"]
    }
  end
end


