class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing]

  def landing
  end

  def home
      @associe = current_user.roles.where(category: 'Associe')
      @investisseur = current_user.roles.where(category: 'Investisseur')
      @company = Company.new
  end

end
