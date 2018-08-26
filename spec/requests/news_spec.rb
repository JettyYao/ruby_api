require 'rails_helper'
RSpec.describe 'News Api' do
    let!(:news) { create_list(:new, 20) }
    let!(:id) { news.last.id }

    describe 'GET /news' do
        before { get '/news' }
        it 'returns last new' do
            expect(json).not_to be_empty
            expect(json['id']).to eq(id)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    describe 'POST /news' do
        let(:valid_attributes) { { content: 'thisi is a test' } }
        context 'when the request is valid' do
            before { post '/news', params: valid_attributes }

            it 'creates a new' do
                expect(json['content']).to eq('thisi is a test')
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do
            before { post '/news', params: { content: '' } }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body).to match(/Validation failed: Content can't be blank/)
            end
        end
    end

    describe 'PUT /news/:id' do
        context 'when the params is valid' do
            let(:valid_attributes) { { content: 'thisi is a test2' } }
            before { put "/news/#{id}", params: valid_attributes }

            it 'returns the new data' do
                expect(json['content']).to eq('thisi is a test2')
            end

            it 'return status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the params is invalid' do
            before { put "/news/#{id}", params: { content: '' } }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body).to match(/Validation failed: Content can't be blank/)
            end
        end
    end

    describe 'DELETE /news/:id' do
        before { delete "/news/#{id}" }
        
        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end 