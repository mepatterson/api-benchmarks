class APIv1
  class Items < Grape::API

    version 'v1', using: :path

    resource :items do

      # GET /items.json
      desc "Returns list of all Items."
      get '/' do
        @items = Item.all
        render_custom "api_v1/items/index", @items, 200
      end

      # GET /items/random.json
      desc "Returns a single Item at random"
      get '/random' do
        @item = Item.random
        render_custom "api_v1/items/show", @item, 200
      end

      # GET /items/2f7210cc-cda6-4e92-b658-7c3acfa985b8.json
      desc "Returns a single Unlock record by UUID"
      get "/:uuid" do
        @item = Item.where(uuid: params[:uuid]).first
        render_custom "api_v1/items/show", @item, 200
      end

    end
  end
end