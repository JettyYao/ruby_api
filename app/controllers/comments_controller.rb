class CommentsController < ApplicationController
    before_action :set_post
    before_action :set_post_comment, only: [:destroy]

    def index
        json_response(@post.comments.as_json(:include=> :replies))
    end

    def create
        @post.comments.create!(comment_params)
        json_response(@post.comments, :created)
    end

    def destroy
        @comment.destroy
        head :no_content
    end

    private

    def comment_params
        params.permit(:username, :account, :content)
    end

    def set_post
        @tag = Tag.find(params[:tag_id])
        @post = @tag.posts.find_by!(id: params[:post_id]) if @tag
    end

    def set_post_comment
        @comment = @post.comments.find_by!(id: params[:id]) if @post
    end
end
