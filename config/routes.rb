Rails.application.routes.draw do
  api vendor_string: "crud_api", default_version: 1, defaults: { format: :json } do
    version 1 do
      cache as: 'v1' do
        resources :products, except: [:new, :edit]
      end
    end
  end
end
