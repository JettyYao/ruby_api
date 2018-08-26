class NewsController < ApplicationController

    before_action :set_new, only: [:update, :destroy]

    def index
        @new = New.last
        if @new
            json_response(@new)
        else
            json_response({content: '暂无数据'})
        end
    end

    def create
        @new = New.create!(new_params)
        json_response(@new, :created)
    end

    def update
        @new.update!(new_params)
        json_response(@new)
    end

    def destroy
        @new.destroy
        head :no_content
    end

    private

    def new_params
        params.permit(:content)
    end

    def set_new
        @new = New.find(params[:id])
    end
end
