
Deface::Override.new(virtual_path: "spree/admin/taxonomies/_list",
                     name: "remove_useless_translation_button",
                     remove: "a")
Deface::Override.new(virtual_path: "spree/admin/shared/_product_tabs",
                     name: "remove_useless_translation_button",
                     remove: "li:last-child")

Deface::Override.new(virtual_path: "spree/admin/promotions/index",
                     name: "remove_useless_translation_button",
                     remove: ".action-translate")
