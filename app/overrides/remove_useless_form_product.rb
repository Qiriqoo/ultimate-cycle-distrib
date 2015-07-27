
Deface::Override.new(virtual_path: "spree/admin/products/_form",
                     name: "remove_useless_form_product",
                     remove: "[data-hook='admin_product_form_cost_price'], [data-hook='admin_product_form_cost_currency'], [data-hook='admin_product_form_multiple_variants']")

Deface::Override.new(virtual_path: "spree/admin/variants/_form",
                     name: "remove_useless_form_product",
                     remove: "[data-hook='cost_price']")


Deface::Override.new(virtual_path: "spree/admin/product_properties/index",
                     name: "remove_useless_form_product",
                     remove: ".js-new-ptype-link")

