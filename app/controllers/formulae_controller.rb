class FormulaeController < ApplicationController
  def search
    if @q = params[:q]
      begin
        @formula = Formula.load @q.gsub /\&/, '+'
        @results = Space.where(id: @formula.spaces).paginate(
          page: params[:page], per_page: 30)
      rescue Formula::ParseError => e
        @error = e
        # Search elasticsearch ... TODO: use Search.search once implemented
        @results = Space.search(@q).page(params[:page]).records
      end
    end
  end
end
