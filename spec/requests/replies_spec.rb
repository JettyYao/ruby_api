require 'rails_helper'
RSpec.describe 'Comments Api' do
    let!(:tag) { create(:tag) }
    let!(:pOst) { create(:post, tag_id: tag.id) }  #注意，写对象时注意名称不要与路由相冲突
    let!(:comment) { create(:comment, post_id: pOst.id)}
    let!(:replies) { create_list(:reply, 20, comment_id: comment.id)}
    let(:tag_id) { tag.id }
    let(:post_id) { pOst.id }
    let(:comment_id) { comment.id }
    let(:id) { replies.first.id }

    describe 'GET /tags/:tag_id/posts/:post_id/comments/comment_id/replies' do
        before { get "/tags/#{tag_id}/posts/#{post_id}/comments/#{comment_id}/replies" }

        context 'when comment exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns all comment replies' do
                expect(json.size).to eq(20)
            end
        end

        context 'when comment does not exists' do
            let(:comment_id) { 0 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Comment/)
            end
        end
    end

    describe 'POST /tags/:tag_id/posts/:post_id/comments/comment_id/replies' do
        let(:valid_attributes) { { username: 'JETTY', account: '13422496263@163.com', content: 'THIS IS NOT A REAL POST'} }

        context 'when reply request attributes are valid' do
            before { post "/tags/#{tag_id}/posts/#{post_id}/comments/#{comment_id}/replies", params: valid_attributes }
            
            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when reply request attributes are invalid' do
            before { post  "/tags/#{tag_id}/posts/#{post_id}/comments/#{comment_id}/replies", params: {} }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a failure message' do
                expect(response.body).to match(/Validation failed: Username can't be blank/)
            end
        end
    end

    describe 'DELETE /tags/:tag_id/posts/:post_id/comments/:comment_id/replies/:id' do
        before { delete "/tags/#{tag_id}/posts/#{post_id}/comments/#{comment_id}/replies/#{id}" }

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end 