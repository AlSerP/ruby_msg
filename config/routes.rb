Rails.application.routes.draw do
  get 'dialogue/:id', to: 'dialogues#show', constraint: {id: /\d+/}
  get 'dialogue/:id/show', to: 'dialogues#show', constraint: {id: /\d+/}
  get 'dialogue/:id/update', to: 'dialogues#update_message', constraint: {id: /\d+/}
  get 'dialogue/start/:id', to: 'dialogues#start_dialogue', constraint: {id: /\d+/}
  post 'dialogue/:id/send', to: 'dialogues#send_msg', constraint: {id: /\d+/}

  root to: 'welcome#index'
  get 'users', to: 'welcome#show_all_users'
  get 'dialogues', to: 'welcome#user_dialogues'

end
