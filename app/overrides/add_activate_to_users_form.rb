Deface::Override.new(:virtual_path => "spree/admin/users/index",
                     :name => "add_activate_button_to_users_index",
                     :insert_bottom => "td.user_email",
                     :text => "<span class='pull-right'><%= user.has_spree_role?('admin') ? Spree.t(:administrator) : Spree.t(:enterprise) %> - <%= user.active ? Spree.t(:active) : Spree.t(:inactive) %></span>")

Deface::Override.new(:virtual_path => "spree/admin/users/_form",
                     :name => "add_activate_button_to_users_index2",
                     :insert_after => "[data-hook='admin_user_form_roles']",
                     :text => "<div data-hook='admin_user_form_actif' class='field'>
                                <%= label_tag nil, 'Activation' %>
                                <ul>
                                  <li>
                                    <%= check_box 'user' , 'active', {}, 'true', 'false' %>
                                    <%= label_tag 'active', 'active' %>
                                  </li>
                                </ul>
                              </div>")

