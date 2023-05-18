class EnableConfirmableForUsers < ActiveRecord::Migration[7.0]
  def change
     # Uncomment the lines related to Confirmable
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :unconfirmed_email, :string # Only if using reconfirmable

    # Uncomment the line to add index for confirmation_token
    add_index :users, :confirmation_token, unique: true
  end
end
