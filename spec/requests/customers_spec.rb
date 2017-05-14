require 'rails_helper'

RSpec.describe 'Products API', type: :request do
  #Initialize data
  let(:user) { create(:user) }
  let(:organization) { create(:organization) }
  let(:organization_id) { organization.id }
  let!(:customers) { create_list(:customer, 10, organization_id: organization.id) }
  let(:customer_id) {customers.first.id}
  let(:headers) { valid_headers }

  describe 'GET /v1/organizations/organization_id/customers' do
    before { get "/v1/organizations/#{organization_id}/customers", headers: headers}

    it 'returns customers' do
      expect(json).not_to be_empty
      expect(json['data'].size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /v1/organizations/organization_id/customers/:id' do
    before { get "/v1/organizations/#{organization_id}/customers/#{customer_id}", headers: headers }

    context 'when the record exists' do
      it 'returns the customer' do
        expect(json).not_to be_empty
        expect(json.size).to eq(1)
        expect(json['data']['id']).to eq(customer_id.to_s)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:customer_id) { 120 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Customer/)
      end
    end
  end

  describe 'POST /v1/organizations/organization_id/customers' do
    #valid payload
    let(:valid_attributes) { { name: 'Anakin Skywalker', phone: '2310438889', address: 'Tatoine 26 str', customer_type: 'Company' }}
    let(:invalid_attributes) {{name: 'Anakin Skywalker', address: 'Tatoine 26 str', customer_type: 'Company' }}

    context 'when request is valid' do
      before { post "/v1/organizations/#{organization_id}/customers", params: valid_attributes, headers: headers}

      it 'creates a customer' do
        logger.warn(json.pretty_inspect)
        expect(json['data']['attributes']['name']).to eq('Anakin Skywalker')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when request is invalid' do
      before { post "/v1/organizations/#{organization_id}/customers", params: invalid_attributes, headers: headers}

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Phone can't be blank/)
      end
    end
  end

  describe 'PUT /v1/organizations/organization_id/customers/:id' do
    let(:valid_attributes) {{name: 'Luke Skywalker'}}

    context 'when the customer exists' do
      before { put "/v1/organizations/#{organization_id}/customers/#{customer_id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'updates the attribute of customer' do
        get "/v1/organizations/#{organization_id}/customers/#{customer_id}", headers: headers
        expect(json['data']['attributes']['name']).to eq('Luke Skywalker')
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /v1/organizations/organization_id/customers/:id' do
    before { delete "/v1/organizations/#{organization_id}/customers/#{customer_id}", headers: headers}

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'returns -1 customers' do
      get "/v1/organizations/#{organization_id}/customers", headers: headers
      expect(json['data'].size).to eq(9)
    end
  end
end
