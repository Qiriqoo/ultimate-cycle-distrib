Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "add_submenu_to_users_admin_tab",
                     :insert_bottom => "#main-sidebar",
                     :partial => 'spree/admin/shared/user_sub_menu')

Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "add_reports_menu_to_admin_tab",
                     :insert_bottom => '#main-sidebar',
                     :partial => 'spree/admin/shared/report_menu')

Deface::Override.new(:virtual_path => "spree/layouts/admin",
                     :name => "add_page_menu_to_admin_tab",
                     :insert_bottom => '#main-sidebar',
                     :partial => 'spree/admin/shared/page_menu')
