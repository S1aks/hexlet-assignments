# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#index'

  # BEGIN
  resources :posts do
    scope module: :posts do
      resources :comments, except: [:index, :show, :new]
    end
  end
  # END
end
