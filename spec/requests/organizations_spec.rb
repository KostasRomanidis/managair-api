require 'rails_helper'

RSpec.describe 'Organizations API', type: :request do
  let(:user) { create(:user) }
  let!(:organization) { create(:organization) }
  let(:headers) { valid_headers }
  let(:organization_id) { organization.id }

  describe 'GET /v1/organizations' do
    before { get '/v1/organizations', headers: headers }

    it 'returns organizations' do
      expect(json).not_to be_empty
      logger.warn(json.pretty_inspect)
      expect(json['data'].size).to eq(1)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /v1/organizations/:id' do
    before { get "/v1/organizations/#{organization_id}", headers: headers }

    context 'when the organization exists' do
      it 'returns the organization' do
        expect(json).not_to be_empty
        expect(json.size).to eq(1)
        expect(json['data']['id']).to eq(organization_id.to_s)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the organization does not exist' do
      let(:organization_id) { 250 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Organization/)
      end
    end

  end

  describe 'POST /v1/organizations' do
    let(:valid_payload) { {name: 'Roman Corporation'} }
    let(:invalid_payload) { }

    context 'when the request is valid' do
      before { post '/v1/organizations', params: valid_payload, headers: headers}

      it 'creates an organization' do
        expect(json['data']['attributes']['name']).to eq('Roman Corporation')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/v1/organizations', params: invalid_payload, headers: headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/Validation failed: Name can't be blank/)
      end
    end
  end

  describe 'PUT /v1/organizations/:id' do
    let(:valid_attributes) {{ name: 'Umprella Corporation' }}

    context 'when the organization exists' do
      before { put "/v1/organizations/#{organization_id}", params: valid_attributes, headers: headers }

      it 'updates the organization' do
        expect(response.body).to be_empty
      end

      it 'update the attribute of the organization' do
        get "/v1/organizations/#{organization_id}", headers: headers
        expect(json['data']['attributes']['name']).to eq('Umprella Corporation')
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /v1/organizations/:id' do
    before { delete "/v1/organizations/#{organization_id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
