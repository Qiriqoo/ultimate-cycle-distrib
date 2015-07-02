Spree::FrontendHelper.class_eval do  
  def get_taxonomies
    @taxonomies ||= Spree::Taxonomy.includes(:root)
  end
end

