class EmailsController < ApplicationController
    before_action :set_email, only: [:show, :destroy, :change_status]

    def index
        @emails = Email.order(isread: :asc)
        json_response(@emails)
    end

    def show
        json_response(@email)
    end

    def create
        @email = Email.create!(email_params)
        json_response(@email, :created)
    end

    def destroy
        @email.destroy
        head :no_content
    end

    def change_status
        @email.update(isread: true)
    end

    private

    def email_params
        params.permit(:username, :account, :content)
    end

    def set_email
        @email = Email.find(params[:id])
    end

end
