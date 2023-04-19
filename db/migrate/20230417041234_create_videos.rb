class CreateVideos < ActiveRecord::Migration[7.0]
  def change
    create_table :videos do |t|
      t.references :videoable, polymorphic: true
      t.string :title
      t.string :description
      t.string :display_id
      t.string :thumbnail

      t.timestamps
    end
  end
end
