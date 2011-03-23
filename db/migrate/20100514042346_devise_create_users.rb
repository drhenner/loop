class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      ##  THIS info goes into signup-info
      t.string :first_name, :length => 40
      t.string :encrypted_last_name,  :length => 200
      t.date   :birth_date

      t.string :email,   :unique => true
      t.string :state
      t.integer :account_id
      t.string :customer_cim_id ## This is the ID returned from AUTH.NET
      t.string :password_salt
      t.string :crypted_password
      t.string :perishable_token,   :unique => true
      t.string :persistence_token,   :unique => true
      t.string :access_token,   :unique => true
      t.integer :comments_count, :default => 0

      #t.database_authenticatable :null => false
      #t.confirmable
      #t.recoverable
      #t.rememberable
      #t.trackable

      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable

      t.timestamps
    end

    #add_index :users, :first_name
    execute('CREATE INDEX users_first_name_ten ON users (first_name(8));')
    execute('CREATE INDEX users_last_name_ten ON users (encrypted_last_name(8));')
    execute('CREATE INDEX users_email_ten ON users (email(20));')
    execute('CREATE INDEX users_perishable_token_ten ON users (perishable_token(10));')
    execute('CREATE INDEX users_persistence_token_ten ON users (persistence_token(10));')
    execute('CREATE INDEX users_access_token_ten ON users (access_token(10));')
    #add_index :users, :last_name
    #add_index :users, :email,               :unique => true
    #add_index :users, :perishable_token,    :unique => true
    #add_index :users, :persistence_token,   :unique => true
    #add_index :users, :access_token,        :unique => true
    #add_index :users, :confirmation_token,   :unique => true
    #add_index :users, :confirmation_token,   :unique => true
    #add_index :users, :reset_password_token, :unique => true
    # add_index :users, :unlock_token,         :unique => true
  end

  def self.down
    drop_table :users
  end
end
