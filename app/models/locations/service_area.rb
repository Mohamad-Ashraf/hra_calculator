module Locations
  class ServiceArea
    include Mongoid::Document
    include Mongoid::Timestamps

    field :active_year, type: Integer
    field :issuer_provided_title, type: String
    field :issuer_provided_code, type: String
    field :issuer_hios_id, type: String
    # The list of county-zip pairs covered by this service area
    field :county_zip_ids, type: Array

    # This service area may cover entire state(s), if it does,
    # specify which here.
    field :covered_states, type: Array

  end
end
