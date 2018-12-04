class UserMailer < ApplicationMailer
  def welcome(user)
    @greeting_male = "Cher"
    @greeting_female = "Chère"
    @user = user
    mail(to: @user.email, subject: 'Bienvenue sur superclosing.com !')
  end
end
