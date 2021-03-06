module Products::Operations
  class FetchProducts
    include Dry::Transaction::Operation

    def call(hra_object)
      # age = ::Operations::AgeLookup.new.call(hra_object.age).success

      tenant = Tenants::Tenant.find_by_key(hra_object.tenant)

      query_criteria = {
          :premium_tables.exists => true,
          :"premium_tables.premium_tuples".exists => true,
          :"premium_tables.effective_period.min".lte => hra_object.start_month,
          :"premium_tables.effective_period.max".gte => hra_object.start_month
      }

      if tenant.geographic_rating_area_model == 'zipcode'
        query_criteria.merge!({
          :"service_area_id".in => hra_object.service_area_ids,
          :"premium_tables.rating_area_id" => BSON::ObjectId.from_string(hra_object.rating_area_id)
          })
      end

      if tenant.geographic_rating_area_model == 'county'
        query_criteria.merge!({:"service_area_id".in => hra_object.service_area_ids})
      end

      products = tenant.products.where(query_criteria)
     
      if products.present?
        Success(products)
      else
        hra_object.errors += ['Could Not find any Products for the given data']
        Failure(hra_object)
      end
    end
  end
end
