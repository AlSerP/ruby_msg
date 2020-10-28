Rails.application.routes.draw do
  get 'dialogues', to: 'dialogues#show'
  get 'dialogues/update', to: 'dialogues#update_message'
  get 'dialogue/start/:id', to: 'dialogues#start_dialogue', constraint: {id: /\d+/}
  post 'dialogues/send', to: 'dialogues#send_msg'

  root to: 'welcome#index'
  get 'users', to: 'welcome#show_all_users'
  get 'dialogues', to: 'welcome#user_dialogues'

end
