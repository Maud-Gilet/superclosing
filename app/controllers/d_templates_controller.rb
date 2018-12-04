class DTemplatesController < ApplicationController
  before_action :set_d_template, only: [:show, :edit, :update]

  def index
    @d_templates = DTemplate.all
  end

  def show
  end

  def new
    @d_template = DTemplate.new
  end

  def create
    @d_template = DTemplate.new(d_template_params)

    if @d_template.save
      redirect_to current_user_dashboard_path, notice: 'Votre template a bien été créé.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @d_template.update(d_template_params)
    if @d_template.update(d_template_params)
      redirect_to current_user_dashboard_path, notice: 'Votre template a bien été mis à jour.'
    else
      render :edit
    end
  end

  private

  def set_d_templates
    @d_template = DTemplate.find(params[:id])
  end

  def d_template_params
    params.require(:d_template).permit(:category, :version)
  end
end
