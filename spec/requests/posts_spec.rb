require 'rails_helper'
RSpec.describe 'Posts Api' do
    let!(:tag) { create(:tag) }
    let!(:posts) { create_list(:post, 20, tag_id: tag.id) }
    let(:tag_id) { tag.id }
    let(:id) { posts.first.id }

    describe 'GET /tags/:tag_id/posts' do
        before { get "/tags/#{tag_id}/posts" } 

        context 'when tag exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns all tag posts' do
                expect(json.size).to eq(20)
            end
        end

        context 'when tag does not exist' do
            let(:tag_id) { 0 }

            it ' returns status code 404 ' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Tag/)
            end
        end
    end

    describe 'GET /tags/:tag_id/posts/:id' do
        before { get "/tags/#{tag_id}/posts/#{id}"}

        context 'when tag post exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns the post' do
                expect(json['id']).to eq(id)
            end
        end

        context 'when tag post does not exist' do
            let(:id) { 0 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
            
            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Post/)
            end
        end
    end

    describe 'POST /tags/:tag_id/posts' do
        let(:valid_attributes) { { title: 'This is a Lorem', author: 'JETTY', content: 'THIS IS NOT A REAL POST'}}

        context 'when request attributes are valid' do
            before { post "/tags/#{tag_id}/posts", params: valid_attributes }

            it 'returns status code 201' do 
                expect(response).to have_http_status(201)
            end
        end

        context 'when an invalid request' do
            before { post "/tags/#{tag_id}/posts", params: {} }

            it 'returns status code 422' do
                 expect(response).to have_http_status(422)
            end

            it 'returns a failure message' do
                expect(response.body).to match(/Validation failed: Title can't be blank/)
            end
        end
    end

    describe 'PUT /tags/:tag_id/posts/:id' do
        let(:valid_attributes) { { title:'This is a Test', author: 'JETTY', content: 'THIS IS NOT A REAL POST' } }

        before { put "/tags/#{tag_id}/posts/#{id}", params: valid_attributes }

        context 'when post exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'updates the post' do
                updated_post = Post.find(id)
                expect(updated_post.title).to match(/This is a Test/)
            end
        end

        context 'when the post does not exist' do
            let(:id) { 0 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Post/)
            end
        end
    end

    describe 'DELETE /tags/:tag_id/posts/:id' do
        before { delete "/tags/#{tag_id}/posts/#{id}" }

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end
