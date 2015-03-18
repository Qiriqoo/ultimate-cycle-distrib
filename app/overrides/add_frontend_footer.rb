
Deface::Override.new(:virtual_path => "spree/layouts/spree_application",
                     :name => "add_frontend_footer",
                     :insert_bottom => "[data-hook='body']",
                     :text => "<%= render partial: 'spree/shared/footer' %>")


