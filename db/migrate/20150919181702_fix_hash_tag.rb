class FixHashTag < ActiveRecord::Migration
  def change
  	rename_column :hash_tags, :hash, :tag
  end
end
