class AboutsController < ApplicationController
    before_action :set_about, only: [:update]

    def index
        @about = About.last
        if @about
            json_response(@about)
        else
            json_response({content: '暂无数据'})
        end
    end

    def create
        @about = About.create!(about_params)
        json_response(@about, :created)
    end

    def update
        @about.update!(about_params)
        json_response(@about)
    end

    private

    def about_params
        params.permit(:content)
    end

    def set_about
        @about = About.find(params[:id])
    end
end
