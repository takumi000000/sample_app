class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets do |t|
      t.text :content, :null=> false
      t.string :tweet_user 
      t.timestamps
    end
  end
end
