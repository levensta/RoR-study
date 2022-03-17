Rails.application.routes.draw do
  root 'main#title'
  get 'title', to: 'main#title'
  get 'power', to: 'main#power'
  get 'worldmap', to: 'main#worldmap'
  get 'battle', to: 'main#battle'
  get 'result' => "main#result"
  get 'moviedex', to: 'main#moviedex'
  get 'save', to: 'main#save'
  get 'ending' => "main#ending"
end
