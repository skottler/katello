#
# Copyright 2011 Red Hat, Inc.
#
# This software is licensed to you under the GNU General Public
# License as published by the Free Software Foundation; either version
# 2 of the License (GPLv2) or (at your option) any later version.
# There is NO WARRANTY for this software, express or implied,
# including the implied warranties of MERCHANTABILITY,
# NON-INFRINGEMENT, or FITNESS FOR A PARTICULAR PURPOSE. You should
# have received a copy of GPLv2 along with this software; if not, see
# http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
module Navigation
  module AdministrationMenu
    def self.included(base)
      base.class_eval do
        helper_method :user_navigation
      end
    end

    def user_navigation
      [
          { :key => :general,
            :name =>N_("General"),
            :url => (@user.nil? || @user.new_record?) ? "" : edit_user_path(@user.id),
            :if => lambda{!@user.nil?},
            :options => {:class=>"navigation_element"}
          },
          { :key => :environment,
            :name =>N_("Environments"),
            :url => (@user.nil? || @user.new_record?) ? "" : edit_environment_user_path(@user.id),
            :if => lambda{!@user.nil?},
            :options => {:class=>"navigation_element"}
          },
          { :key => :roles_and_permissions,
            :name =>N_("Roles & Permissions"),
            :url => (@user.nil? || @user.new_record?) ? "" : edit_role_path(@user.own_role_id),
            :if => lambda{!@user.nil?},
            :options => {:class=>"navigation_element"}
          }
      ]
    end

    def menu_administration
      {:key => :admin,
       :name => N_("Administration"),
        :url => :sub_level,
        :options => {:class=>'operations top_level', "data-menu"=>"operations"},
        :if => :sub_level,
        :items=> [ menu_users, menu_roles]
      }
    end


    def menu_users
      {:key => :users,
       :name => N_("Users"),
       :url => users_path,
       :if =>lambda {User.any_readable?},
       :options => {:class=>'operations second_level', "data-menu"=>"operations"}
      }
    end

    def menu_roles
      {:key => :roles,
       :name => N_("Roles"),
       :url => roles_path,
       :if =>lambda {Role.any_readable?},
       :options => {:class=>'operations second_level', "data-menu"=>"operations"}
      }
    end

  end
end