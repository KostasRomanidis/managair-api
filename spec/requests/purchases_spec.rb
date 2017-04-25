require 'rails_helper'

RSpec.describe 'Purchases API', type: :request do
  let(:user) { create(:user) }
  let(:organization) { create(:organization) }
  let(:organization_id) { organization.id }
  let(:product) { create(:product, organization_id: organization_id)}
  let(:product_2) { create(:product, organization_id: organization_id)}
  let(:customer) { create(:customer, organization_id: organization_id) }
  let(:product_id) { product.id }
  let(:product_2_id) { product_2.id }
  let(:customer_id) { customer.id }
  let!(:purchases) { create_list(:purchase, 10, product_id: product_id, customer_id: customer_id, organization_id: organization_id)}
  let(:purchase_id) { purchases.first.id }
  let(:headers) { valid_headers }

  describe 'GET /v1/organizations/organization_id/customers/:customer_id/purchases' do
    before { get "/v1/organizations/#{organization_id}/customers/#{customer_id}/purchases", headers: headers}

    it 'returns purchases' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /v1/organizations/organization_id/customers/:customer_id/purchases/:id' do
    before { get "/v1/organizations/#{organization_id}/customers/#{customer_id}/purchases/#{purchase_id}", headers: headers }

    context 'when the record exists' do
      it 'returns the purchase' do
        expect(json).not_to be_empty
        expect(json.size).to eq(1)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:purchase_id) { 789 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Purchase with 'id'=#{purchase_id}/)
      end
    end
  end

  describe 'POST /v1/organizations/organization_id/customers/:customer_id/purchases' do
    let(:valid_attributes) { { purchase_date: '2017-03-29 10:01:04.537419', customer_id: :customer_id, product_id: 1}}

    context 'when request is valid' do
      before { post "/v1/organizations/#{organization_id}/customers/#{customer_id}/purchases", params: valid_attributes, headers: headers }

      it 'creates a new purchase' do
        expect(json['data']['attributes']['customer-id']).to eq(customer_id)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post "/v1/organizations/#{organization_id}/customers/#{customer_id}/purchases", params: { customer_id: :customer_id, product_id: 1}, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Purchase date can't be blank/)
      end
    end
  end

  describe 'PUT /v1/organizations/organization_id/customers/customer_id/purchases/:id' do
    let(:valid_attributes) {{product_id: product_2_id}}

    context 'when the purchase exists' do
      before { put "/v1/organizations/#{organization_id}/customers/#{customer_id}/purchases/#{purchase_id}", params: valid_attributes, headers: headers}

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'updates the attribute of the purchases' do
        get "/v1/organizations/#{organization_id}/customers/#{customer_id}/purchases/#{purchase_id}", headers: headers
        expect(json['data']['attributes']['product-id']).to eq(product_2_id)
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /v1/organizations/organization_id/customers/customer_id/purchases/:id' do
    before { delete "/v1/organizations/#{organization_id}/customers/#{customer_id}/purchases/#{purchase_id}", headers: headers}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'returns minus 1 customers purchase' do
      get "/v1/organizations/#{organization_id}/customers/#{customer_id}/purchases", headers: headers
      expect(json['data'].size).to eq(9)
    end

  end
end
