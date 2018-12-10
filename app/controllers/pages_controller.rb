class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:landing]

  def landing
  end

  def home
    @partner = current_user.roles.where('roles.category = ? ', 'Associe')
    @president = current_user.roles.where('roles.category = ?', 'Président')
    @investisseur = current_user.roles.where(category: 'Investisseur')
    @distinct_companies = Company.joins(:roles).where('roles.user_id = ?', current_user).sort.uniq
    @company = Company.new
  end
end
