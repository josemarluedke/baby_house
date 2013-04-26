# Encoding: utf-8
class ApplyForm < MailForm::Base
  attribute :name, validate: true
  attribute :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :phone, validate: true
  attribute :role, validate: true
  attribute :specialist_teacher
  attribute :role_other
  attribute :already_sent, validate: true
  attribute :already_sent_year
  attribute :already_apply, validate: true
  attribute :already_apply_year
  attribute :file, attachment: true, validate: :validate_file
  attribute :others

  def validate_file
    return true unless file.present?

    unless file.original_filename.match(%r{\.(png|jpg|jpeg|doc|docx|pdf|pps|ppsx)$}i)
      self.errors.add(:file, "Extensão inválida")
    end
  end

  def headers
    {
      :subject => "Currículo para trabalhar na Baby House",
      :to => "curriculos@escolababyhouse.com"
    }
  end
end

