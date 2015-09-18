class CreatePosts < ActiveRecord::Migration
	def change
		create_table :posts do |t|
			t.integer :user_id
			t.text :caption
			t.string :img_url
			t.timestamps null: false
		end
	end
end
