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
      :subject => "Oferecer produto(s) ou serviço(s) pelo site Baby House - #{sector_text[sector.to_i]}",
      :to => emails[sector.to_i]
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

  def sector_text
    {
      1 => "Higiene, limpeza e manutenção",
      2 => "Alimentação",
      3 => "Administrativo",
      4 => "Pedagógico",
      5 => "Direção",
      6 => "Outros"
    }
  end
end

