class PostsController < ApplicationController
    before_action :set_tag
    before_action :set_tag_post, only: [:show, :update, :destroy]

    def index
        json_response(@tag.posts)
    end

    def show
        json_response(@post)
    end

    def create
        @tag.posts.create!(post_params)
        json_response(@tag.posts, :created)
    end

    def update
        @post.update(post_params)
        json_response(@post)
    end

    def destroy
        @post.destroy
        head :no_content
    end

    private

    def post_params
        params.permit(:title, :author, :content)
    end

    def set_tag
        @tag = Tag.find(params[:tag_id])
    end

    def set_tag_post
        @post = @tag.posts.find_by!(id: params[:id]) if @tag
    end
end
