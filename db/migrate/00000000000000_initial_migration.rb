class InitialMigration < ActiveRecord::Migration

  def change

    create_table :users do |t|
      t.string :name
      t.timestamps
    end

    create_table :libraries do |t|
      t.string :name
      t.string :slug
      t.references :user
      t.timestamps
    end

    create_table :library_contents do |t|
      t.references :library
      t.references :artist
      t.timestamps
    end

    create_table :artists do |t|
      t.string :name
      t.string :slug
      t.timestamps
    end

    create_table :albums do |t|
      t.string :name
      t.string :slug
      t.integer :length
      t.references :artist
      t.timestamps
    end

    create_table :tracks do |t|
      t.string :name
      t.string :slug
      t.integer :length
      t.references :album
      t.timestamps
    end

  end

end