require 'rails_helper'
RSpec.describe 'Comments Api' do
    let!(:tag) { create(:tag) }
    let!(:pOst) { create(:post, tag_id: tag.id) }  #注意，写对象时注意名称不要与路由相冲突
    let!(:comments) { create_list(:comment, 20, post_id: pOst.id)}
    let(:tag_id) { tag.id }
    let(:post_id) { pOst.id }
    let(:id) { comments.first.id }

    describe 'GET /tags/:tag_id/posts/:post_id/comments' do
        before { get "/tags/#{tag_id}/posts/#{post_id}/comments" }

        context 'when post exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns all post comments' do
                expect(json.size).to eq(20)
            end
        end

        context 'when post does not exists' do
            let(:post_id) { 0 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Post/)
            end
        end
    end

    describe 'POST /tags/:tag_id/posts/:post_id/comments' do
        let(:valid_attributes) { { username: 'JETTY', account: '13422496263@163.com', content: 'THIS IS NOT A REAL POST'} }

        context 'when comment request attributes are valid' do
            before { post "/tags/#{tag_id}/posts/#{post_id}/comments", params: valid_attributes }
            
            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when comment request attributes are invalid' do
            before { post  "/tags/#{tag_id}/posts/#{post_id}/comments", params: {} }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a failure message' do
                expect(response.body).to match(/Validation failed: Username can't be blank/)
            end
        end
    end

    describe 'DELETE /tags/:tag_id/posts/:post_id/comments/:id' do
        before { delete "/tags/#{tag_id}/posts/#{post_id}/comments/#{id}" }

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end 