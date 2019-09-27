class HraResultsController < ApplicationController

  def hra_counties
    counties_lookup = Operations::CountiesLookup.new.call(params.permit!['hra_zipcode'] || '')
    render plain: {status: "success", data: counties_lookup.success.to_h}.to_json, content_type: 'application/json'
  end

  def hra_information
    hra_default_setter = ::Operations::HraDefaultSetter.new.call
    render plain: {status: "success", data: hra_default_setter.success.to_h}.to_json, content_type: 'application/json'
  end

  def hra_payload
    determine_affordability = ::Transactions::DetermineAffordability.new.call(formatted_params)

    if determine_affordability.success?
      render plain: {status: "success", data: determine_affordability.success}.to_json, content_type: 'application/json'
    else
      # render plain: {status: "failure", data: determine_affordability.failure.to_h}.to_json, content_type: 'application/json'
      render plain: {status: "failure", data: {}, errors: determine_affordability.failure[:errors]}.to_json, content_type: 'application/json'
    end
  end

  def header_footer_config
    hf_setter = ::Operations::HeaderFooterConfigurationSetter.new.call
    render plain: {status: "success", data: hf_setter.success.to_h}.to_json, content_type: 'application/json'
  end

  private

  def formatted_params
    params.permit!
    # TODO: refactor this once we fix the params issue.
    params.to_h['hra_result']
  end
end
