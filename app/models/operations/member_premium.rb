module Operations
  class MemberPremium
    include Dry::Transaction::Operation

    def call(hra_object)
      hra_object.age = ::Operations::AgeOn.new.call(hra_object).success

      rating_area_result = ::Locations::Operations::SearchForRatingArea.new.call(hra_object)
      if rating_area_result.success?
        hra_object.rating_area_id = rating_area_result.success.id.to_s
      else
        return Failure(hra_object)
      end

      service_areas_result = ::Locations::Operations::SearchForServiceArea.new.call(hra_object)
      if service_areas_result.success?
        hra_object.service_area_ids = service_areas_result.success.pluck(:id).map(&:to_s)
      else
        return Failure(hra_object)
      end

      fetch_products_result = ::Products::Operations::FetchProducts.new.call(hra_object)
      return Failure(hra_object) if fetch_products_result.failure?

      lcrp_result = ::Products::Operations::LowCostReferencePlanCost.new.call({products: fetch_products_result.success, hra_object: hra_object})
      if lcrp_result.success?
        Success(lcrp_result.success)
      else
        Failure(hra_object)
      end
    end
  end
end