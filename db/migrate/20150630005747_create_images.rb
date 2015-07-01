class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :file_name

      t.timestamps null: false
    end
  end
end
