# frozen_string_literal: true

Rails.application.routes.draw do
  # BEGIN
  scope '(/:locale)', locale: /en|ru/ do
    root 'home#index'
    resources :posts do
      resources :comments, module: :posts, only: [:create, :edit, :update, :destroy]
    end
  end

  get '/', to: redirect("/#{I18n.default_locale}")
  # END

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
