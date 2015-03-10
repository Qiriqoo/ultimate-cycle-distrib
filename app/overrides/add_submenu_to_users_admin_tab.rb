Deface::Override.new(:virtual_path => "spree/admin/users/index",
                     :name => "add_submenu_to_users_admin_tab",
                     :insert_before => "erb[silent]:contains('content_for :page_title')",
                     :text => "<%= render :partial => 'spree/admin/shared/user_sub_menu' %>")

Deface::Override.new(:virtual_path => "spree/admin/reports/index",
                     :name => "add_submenu_to_reports_admin_tab",
                     :insert_before => "erb[silent]:contains('content_for :page_title')",
                     :text => "<%= render :partial => 'spree/admin/shared/report_sub_menu' %>")
