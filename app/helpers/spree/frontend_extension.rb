Spree::FrontendHelper.class_eval do  
  def get_taxonomies
    @taxonomies ||= Spree::Taxonomy.includes(:root)
  end
  def custom_taxons_tree (root_taxon, current_taxon, max_level = 1)
    return "" if current_page?("/") || root_taxon.nil?

    root_taxon.children.map do |taxon|
      content_tag :div, class: 'btn-group' do
        css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'btn sub-menu-item active' : 'btn sub-menu-item'
        link_to(taxon.name, seo_url(taxon), class: css_class) +
        taxon_sub_menu(url: "#sub_#{taxon.name.parameterize}") +
        render(partial: 'spree/shared/front_sub_menu', locals: {taxons: taxon.descendants, root_taxon: taxon})
      end
    end.join("\n").html_safe

  end

  def taxon_sub_menu url: nil
    content_tag(:button, nil, class: "btn btn-ucd glyph-bloc dropdown-toggle ", :'data-toggle'=> 'dropdown', :'aria-expanded'=> 'false') do
      content_tag(:span, nil, class: "caret") +
      content_tag(:span, "toggle-dropdown", class: "sr-only")
    end     
  end
end

