Rails.application.routes.draw do

  # 顧客用
  #URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  # config/routes.rb
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  # ジャンル検索
  get 'public/genres/:id/search' => 'public/searches#search_genre'

  # 会員側のルーティング設定
  scope module: :public do
    # トップページ
    root to: "homes#top"
    # アバウトページ
    get "home/about"=>"homes#about"
    # 商品検索
    get "search" => "searches#search"
    # 商品
    resources :items, only: [:index, :show]
    # 顧客
    get 'customers/my_page' => 'customers#show', as: 'my_page'
    get 'customers/information/edit' => 'customers#edit', as: 'edit_information'
    patch 'customers/information' => 'customers#update', as: 'update_information'
    get 'customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw'
    # カート内
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:index, :create, :update, :destroy]
    # 注文情報
    resources :orders, only: [:new, :index, :create, :show]
    post 'confirm' => 'orders#confirm', as: 'confirm'
    get 'thanks' => 'orders#thanks', as: 'thanks'
    # 配送先
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end

  # 管理者側のルーティング設定
  namespace :admin do

    # トップページ(商品一覧画面)
    root to: "homes#top"
    #検索
    get "search" => "searches#search"
    # 商品
    resources :items, only: [:new, :index, :create, :show, :edit, :update]
    # ジャンル
    resources :genres, only: [:index, :create, :edit, :update]
    # 顧客
    resources :customers, only: [:index, :show, :edit, :update]
    # 注文詳細画面(ステータス編集を兼ねる)/注文ステータスの更新
    resources :orders, only: [:show, :update] do
      # 製作ステータスの更新
    resources :order_details, only: [:update]
      end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end