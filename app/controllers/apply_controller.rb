# Encoding: utf-8
class ApplyController < ApplicationController
  def new
    @apply = ApplyForm.new
  end

  def create
    @apply = ApplyForm.new params[:apply_form]
    if @apply.deliver
      redirect_to apply_path(), notice: "Currículo enviado com sucesso!"
    else
      render 'apply/new'
    end
  end
end
