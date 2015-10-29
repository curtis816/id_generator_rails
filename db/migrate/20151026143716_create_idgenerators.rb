class CreateIdgenerators < ActiveRecord::Migration
  def change
    create_table :idgenerators do |t|

      t.timestamps null: false
    end
  end
end
