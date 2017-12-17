# spec/requests/bank_spec.rb
require 'rails_helper'

RSpec.describe 'Bank API', type: :request do
  # initialize test data 
  let!(:bank) { create_list(:bank, 10) }
  let(:bank_id) { bank.first.id }

  # Test suite for GET /bank
  describe 'GET /bank' do
    # make HTTP get request before each example
    before { get '/bank' }

    it 'returns bank' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /bank/:id
  describe 'GET /bank/:id' do
    before { get "/bank/#{bank_id}" }

    context 'when the record exists' do
      it 'returns the bank' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(bank_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

  end

  # Test suite for POST /bank
  describe 'POST /bank' do
    # valid payload
    let(:valid_attributes) { { name: 'HDFC'} }

    context 'when the request is valid' do
      before { post '/bank', params: valid_attributes }

      it 'creates a bank' do
        expect(json['name']).to eq('HDFC')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

  end

  # Test suite for PUT /bank/:id
  describe 'PUT /bank/:id' do
    let(:valid_attributes) { { name: 'ICICI' } }

    context 'when the record exists' do
      before { put "/bank/#{bank_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  # Test suite for DELETE /bank/:id
  describe 'DELETE /bank/:id' do
    before { delete "/bank/#{bank_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end