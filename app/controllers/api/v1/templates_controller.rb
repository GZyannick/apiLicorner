class Api::V1::TemplatesController < Api::V1::BaseController
    def index
      @templates = policy_scope(Template)
    end
    def show
      @template = Template.find(params[:id])
      authorize @template
      jsonCalculator
      @template.json = @json_object 
    end
    
    private

    def jsonCalculator
      @template = Template.find(params[:id])
      contents = @template.content
      content_split = contents.split("\n")
      content_reject =  content_split.reject { |a| a == "     " || a == "    " || a == ""}
      @json_object = {}
      type_and_value_array = []
      content_reject.each_with_index do |content, index|
        content.strip!
      if content_reject[0] == content && content.include?(content.upcase)

        type_and_value_array << {type: "h1", value: content}  
      elsif content.include?(content.upcase)
        type_and_value_array << {type: "h2", value: content} 
        else
          type_and_value_array << {type: "p", value: content}
        end
      end
      @json_object[:template] = type_and_value_array
      return @json_object
    end
  end