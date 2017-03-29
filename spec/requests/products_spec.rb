require 'rails_helper'

RSpec.describe 'Products API', type: :request do
  # Initialize test data
  let!(:products) { create_list(:product, 10) }
  let(:product_id) { products.first.id }

  # Test for GET /v1/products
  describe 'GET /v1/products' do
    before { get '/v1/products' }

    it 'returns products' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test for GET /v1/products/:id
  describe 'GET /v1/products/:id' do
    before { get "/v1/products/#{product_id}" }

    context 'when the record exists' do
      it 'returns the product' do
        expect(json).not_to be_empty
        expect(json.size).to eq(1)
        expect(json['data']['id']).to eq(product_id.to_s)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:product_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Product with 'id'=#{product_id}/)
      end
    end
  end

  # Test for POST /v1/products
  describe 'POST /v1/products' do
    # valid payload
    let(:valid_attributes) { { brand: 'LG', model: 'LG3200HR', cost: 550, btu: 18000 } }

    context 'when request is valid' do
      before { post '/v1/products', params: valid_attributes }

      it 'creates a product' do
        expect(json['data']['attributes']['brand']).to eq('LG')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post '/v1/products', params: { brand: 'LG', model: 'LG3200HR', cost: 550 } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Btu can't be blank/)
      end
    end
  end

  # Test for PUT /v1/products/:id
  describe 'PUT /v1/products/:id' do
    let(:valid_attributes) {{brand: 'Samsung'}}

    context 'when the product exists' do
      before { put "/v1/products/#{product_id}", params: valid_attributes}

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'updates the attribute of the product' do
        get "/v1/products/#{product_id}"
        expect(json['data']['attributes']['brand']).to eq('Samsung')
      end

      it 'return status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  #TEst for DELETE /v1/products/:id
  describe 'DELETE /v1/products/:id' do
    before { delete "/v1/products/#{product_id}"}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'returns -1 products' do
      get '/v1/products'
      expect(json['data'].size).to eq(9)
    end
  end
end
