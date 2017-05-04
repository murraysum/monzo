module Monzo
  class Account

    attr_reader :id, :description, :created

    def initialize(params)
      @id = params[:id]
      @description = params[:description]
      @created = params[:created]
    end

  end
end
