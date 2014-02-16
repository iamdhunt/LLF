class AddSocialNetworksToMembers < ActiveRecord::Migration
  def change
    add_column :members, :facebook, :string
    add_column :members, :twitter, :string
    add_column :members, :linkedin, :string
    add_column :members, :soundcloud, :string
    add_column :members, :youtube, :string
    add_column :members, :vimeo, :string
    add_column :members, :instagram, :string
    add_column :members, :flickr, :string
    add_column :members, :google, :string
    add_column :members, :pinterest, :string
    add_column :members, :blog, :string
    add_column :members, :website, :string
  end
end
