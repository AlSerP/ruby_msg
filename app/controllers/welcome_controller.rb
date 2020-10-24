class WelcomeController < ApplicationController
  def index; end

  def show_all_users
    @users = User.all
  end

  def user_dialogues
    print params["d"]
    @dialogues_owner = Dialogue.where user1: current_user.id
    @dialogues_outsider = Dialogue.where user2: current_user.id
    @dialogues = @dialogues_owner | @dialogues_outsider
  end
end
