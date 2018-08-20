class TagsController < ApplicationController
    before_action :set_tag, only: [:show, :update, :destroy]

    def index
        # @tags = Tag.includes(:posts).all.map{|tag| [tag, child: tag.posts]}
        @tags = Tag.all.as_json(:include=> :posts) #正解
        json_response(@tags)
    end

    def create
        @tag = Tag.create!(tag_params)
        json_response(@tag, :created)
    end

    def show
        json_response(@tag)
    end

    def update
        @tag.update(tag_params)
        head :no_content
    end

    def destroy
        @tag.destroy
        head :no_content
    end

    private

    def tag_params
        params.permit(:tag_name, :created_by)
    end

    def set_tag
        @tag = Tag.find(params[:id])
    end
end
