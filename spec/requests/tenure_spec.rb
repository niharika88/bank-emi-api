# app/requests/tenure_spec.rb
require 'rails_helper'

RSpec.describe 'Tenure API' do
  # Initialize the test data


  # Test suite for GET /banks/:bank_id/tenures
  describe 'GET /bank/:bank_id/tenure' do
    let!(:bank) { create(:bank) }
    let!(:tenure) { create(:tenure, bank_id: bank.id) }
    let(:bank_id) { bank.id }
    let(:id) { tenure.id }
    before { get "/bank/#{bank_id}/tenure" }

    context 'when bank exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all bank tenures' do
        expect(json.size).to eq(7)
      end
    end

  end

  # Test suite for GET /banks/:bank_id/tenures/:id
  describe 'GET /bank/:bank_id/tenure/:id' do
    let!(:bank) { create(:bank) }
    let!(:tenure) { create(:tenure, bank_id: bank.id) }
    let(:bank_id) { bank.id }
    let(:id) { tenure.id }
    before { get "/bank/#{bank_id}/tenure/#{id}" }

    context 'when bank tenure exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the tenure' do
        expect(json['id']).to eq(id)
      end
    end
  end

  # Test suite for POST /banks/:bank_id/tenure
  describe 'POST /bank/:bank_id/tenure' do
    let!(:bank) { create(:bank) }
    let(:valid_attributes) { { rate: 1, month: 3, minimum_amount: 1000 } }
    let(:bank_id) { bank.id }
    context 'when request attributes are valid' do
      before { post "/bank/#{bank_id}/tenure", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do

      it 'returns a failure message' do
        expect { post "/bank/#{bank_id}/tenure", params: {} }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  # Test suite for PUT /banks/:bank_id/tenures/:id
  describe 'PUT /bank/:bank_id/tenure/:id' do
    let(:valid_attributes) { { rate: 3 } }
    let!(:bank) { create(:bank) }
    let(:bank_id) { bank.id }
    let!(:tenure) { create(:tenure, bank_id: bank.id) }
    let(:id) { tenure.id }

    before { put "/bank/#{bank_id}/tenure/#{id}", params: valid_attributes }

    context 'when tenure exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the tenure' do
        updated_tenure = Tenure.find(id)
        expect(updated_tenure.rate).to match(3)
      end
    end
  end

  # Test suite for DELETE /bank/:id
  describe 'DELETE /bank/:id' do
    let!(:bank) { create(:bank) }
    let(:bank_id) { bank.id }
    let!(:tenure) { create(:tenure, bank_id: bank.id) }
    let(:id) { tenure.id }
    before { delete "/bank/#{bank_id}/tenure/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
