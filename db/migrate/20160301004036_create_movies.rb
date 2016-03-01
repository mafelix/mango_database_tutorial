class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.string :direction
      t.integer :runtime_in_minutes
      t.text :description
      t.string :post_image_url
      t.datetime :release_date

      t.timestamps
    end
  end
end
