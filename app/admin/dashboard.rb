ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    div :class => "blank_slate_container", :id => "dashboard_default_message" do
      span :class => "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    section "Recent Members" do
        table_for Member.order("created_at desc").limit(15) do
            column :id
            column :user_name do |member|
                link_to member.user_name, [:admin, member]
            end
            column :full_name
            column :email
            column :created_at
        end
        strong { link_to "View All Members", admin_members_path }
    end

    section "Recent Listings" do
        table_for Listing.order("created_at desc").limit(15) do
            column :id
            column :title do |listing|
                link_to listing.title, [:admin, listing]
            end
            column :link
            column :category
            column :price
            column :created_at
        end
        strong { link_to "View All Listings", admin_listings_path }
    end 

    section "Recent Events" do
        table_for Event.order("created_at desc").limit(15) do
            column :id
            column :name do |event|
                link_to event.name, [:admin, event]
            end
            column :category
            column :start_date
            column :end_date
            column :start_time
            column :end_time
            column :created_at
        end
        strong { link_to "View All Events", admin_events_path }
    end 

    section "Recent Projects" do
        table_for Project.order("created_at desc").limit(15) do
            column :id
            column :name do |project|
                link_to project.name, [:admin, project]
            end
            column :category
            column :website
            column :city
            column :created_at
        end
        strong { link_to "View All Projects", admin_projects_path }
    end 

    section "Recent Statuses" do
        table_for Status.order("created_at desc").limit(15) do
            column :id
            column :content
            column :created_at
        end
        strong { link_to "View All Statuses", admin_statuses_path }
    end 

    section "Recent Media" do
        table_for Medium.order("created_at desc").limit(15) do
            column :id
            column :asset_file_name
            column :asset_content_type
            column :asset_file_size
            column :created_at
        end
        strong { link_to "View All Media", admin_media_path }
    end 

    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end
