class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]

  def home
    if user_signed_in?
      @associe = current_user.roles.where(category: 'Associe')
      @investisseur = current_user.roles.where(category: 'Investisseur')
    end
  end
end
