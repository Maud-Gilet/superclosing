class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    @associe = current_user.roles.where(category: 'Associe')
    @investisseur = current_user.roles.where(category: 'Investisseur')
  end

  def dashboard
  end
end
