require 'rails_helper'
RSpec.describe 'Emails Api' do
    let!(:emails) { create_list(:email, 20) }
    let!(:id) { emails.first.id }

    describe 'GET /emails' do
        before { get '/emails' }
        it 'returns emails' do
            expect(json).not_to be_empty
            expect(json.size).to eq(20)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    describe 'GET /emails/:id' do
        before { get "/emails/#{id}" }
        context "when the record exists" do
            it 'returns the tag' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exists' do
            let(:id) { 1000 }
            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Email/)
            end
        end
    end

    describe 'POST /emails' do
        let(:valid_attributes) { { username: 'RUBY', account: '13422496263@163.com', content: 'thisi is a test' } }
        context 'when the request is valid' do
            before { post '/emails', params: valid_attributes }

            it 'creates a email' do
                expect(json['username']).to eq('RUBY')
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do
            before { post '/emails', params: { username: '' } }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body).to match(/Validation failed: Username can't be blank/)
            end
        end
    end

    describe 'DELETE /emails/:id' do
        before { delete "/emails/#{id}" }
        
        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end 