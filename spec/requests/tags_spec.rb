require 'rails_helper'
RSpec.describe 'Tags Api', type: :request do
    #initialize test data
    let!(:tags) { create_list(:tag, 10) }
    let(:tag_id) { tags.first.id }

    describe 'GET /tags' do
        before { get '/tags' }
        it 'returns tags' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    describe 'GET /tags/:id' do
        before { get "/tags/#{tag_id}" }
        context "when the record exists" do
            it 'returns the tag' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(tag_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exists' do
            let(:tag_id) { 100 }
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Tag/)
            end
        end
    end

    describe 'POST /tags' do
        let(:valid_attributes) { { tag_name: 'RUBY', created_by: 'Jetty' } }
        context 'when the request is valid' do
            before { post '/tags', params: valid_attributes }

            it 'creates a tag' do
                expect(json['tag_name']).to eq('RUBY')
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do
            before { post '/tags', params: { tag_name: 'Nothing' } }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body).to match(/Validation failed: Created by can't be blank/)
            end
        end
    end

    describe 'PUT /tags/:id' do
        let(:valid_attributes) { { tag_name: 'CSS'} }
        context 'when the record exists' do
            before { put "/tags/#{tag_id}", params: valid_attributes }
            
            it 'updates the record' do
                expect(response.body).to be_empty
            end
            it 'return status code 204' do
                expect(response).to have_http_status(204)
            end
        end
    end

    describe 'DELETE /tags/:id' do
        before { delete "/tags/#{tag_id}" }
        
        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end