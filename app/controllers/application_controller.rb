class ApplicationController < ActionController::API

  def find_params
    params.require(:id)
  end

  def include_options
    params.slice(:include).as_json.deep_symbolize_keys[:include]
  end
end
