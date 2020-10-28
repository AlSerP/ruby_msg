class DialoguesController < ApplicationController
  def index; end

  def send_msg
    dialogue = Dialogue.find(params['dia'])
    print params
    dialogue.messages.create(order_params)

    @message = dialogue.messages.last

    render json: {message: @message}

    # redirect_to '/dialogue/' + dialogue.id.to_s + '/show'
  end

  def update_message
    dialogue = Dialogue.find(params['dia'])
    if current_user.id == dialogue.user1 || current_user.id == dialogue.user2
      if params['last_message']
        print params['last_message']['time']
        @message = dialogue.messages.find_by(time: params['last_message']['time'])
        print @message.id.to_i
      end
      @messages_all = dialogue.messages

      @messages_to_send = []
      @messages_all.each do |message|
        @messages_to_send << message if message.id.to_i > @message.id.to_i
      end

      render json: {messages: @messages_to_send}
    else
      render json: {}
    end
  end

  def order_params
    params[:user_by] = current_user.id
    params[:time] = Time.zone.now
    print params[:message]
    params.permit(:text, :user_by, :time)
  end

  def check_dialogue(user1, user2)
    # Find a dialogue between two users
    return Dialogue.find_by(user1: user1.id, user2: user2.id) if Dialogue.find_by(user1: user1.id, user2: user2.id)
    return Dialogue.find_by(user1: user2.id, user2: user1.id) if Dialogue.find_by(user1: user2.id, user2: user1.id)

    create_dialogue user1, user2
  end

  def create_dialogue(user1, user2)
    dialogue = Dialogue.new user1: user1.id, user2: user2.id
    dialogue.save
    dialogue
  end

  def show
    @dialogues = user_dialogues
    if params['dia']
      @dialogue = Dialogue.find(params['dia'])
      if check_user current_user, @dialogue
        @messages = @dialogue.messages
        @opponent = if @dialogue.user1 != current_user.id
                      User.find(@dialogue.user1).email
                    else
                      User.find(@dialogue.user2).email
                    end
      else
        render_403
      end
    else
      render 'welcome/user_dialogues'
    end
  end

  def user_dialogues
    @dialogues_owner = Dialogue.where user1: current_user.id
    @dialogues_outsider = Dialogue.where user2: current_user.id
    @dialogues = @dialogues_owner | @dialogues_outsider
  end

  def check_user(user, dialogue)
    user.id == dialogue.user1 || user.id == dialogue.user2
  end

  def start_dialogue
    dialogue = check_dialogue current_user, User.find(params['id'])

    redirect_to '/dialogues?dia=' + dialogue.id.to_s
  end

  def render_404
    render 'public/404', status: '404'
  end

  def render_403
    render 'public/403', status: '403'
  end
end
