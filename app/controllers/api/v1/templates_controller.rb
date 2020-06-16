class Api::V1::TemplatesController < Api::V1::BaseController
    def index
      @templates = policy_scope(Template)
    end
    def show
      @template = Template.find(params[:id])
      authorize @template
    end
  end