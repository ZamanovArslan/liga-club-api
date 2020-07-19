class DestroyActiveStorage < ActiveRecord::Migration[6.0]
  def change
    drop_table :active_storage_blobs, force: :cascade
    drop_table :active_storage_attachments, force: :cascade
  end
end
