class RepliesController < ApplicationController
    before_action :set_comment
    before_action :set_comment_reply, only: [:destroy]

    def index
        json_response(@comment.replies)
    end

    def create
        @comment.replies.create!(reply_params)
        json_response(@comment.replies, :created)
    end

    def destroy
        @reply.destroy
        head :no_content
    end

    private

    def reply_params
        params.permit(:username, :account, :content)
    end

    def set_comment
        @tag = Tag.find(params[:tag_id])
        @post = @tag.posts.find_by!(id: params[:post_id]) if @tag
        @comment = @post.comments.find_by!(id: params[:comment_id]) if @post
    end

    def set_comment_reply
        @reply = @comment.replies.find_by!(id: params[:id]) if @comment
    end
end
