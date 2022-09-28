class TopController < ApplicationController
  def index
    @tweets = Tweet.all.order(created_at: "DESC")
    @tweet = Tweet.new
    @users = User.all
    @user = User.new
    if session[:user_id]
      @fav_list = FavRelation.find_by(user_id: session[:user_id])
    end
    rescue => e
      puts "*****failed index action error=> #{e}*****"
  end

  def create
    @tweets = Tweet.create(tweet_user: params[:userId], content: params[:tweet_content])
    respond_to do |format|
      format.html { redirect_to @tweets } # showアクションを実行し、詳細ページを表示
      format.js  # create.js.erbが呼び出される
    end
  rescue => e
    puts "*****failed create action error=> #{e}*****"
  end
  
  def auth_user
    user_name = params[:user]['user_name']
    check_user = User.find_by(user_name: user_name)

    if check_user == nil
      check_user = User.create(user_name: user_name)
      FavRelation.create(user_id: check_user.id, tweet_id: '')
    end

    session[:user_id] = check_user.id
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
    rescue => e
      puts "*****failed logout action error=> #{e}*****"
  end

  def add_fav
    user_id = params[:userId]
    target_tweet_id = params[:targetId]
    target_fav_relation = FavRelation.find_by(user_id: user_id)
    # いいねしているか判定
    if target_fav_relation.tweet_id.split(' ').include?("#{target_tweet_id}")
      # いいねしていた場合
      puts "いいねしてた"
      target_fav_relation.update!(tweet_id: "#{target_fav_relation.tweet_id.delete("#{target_tweet_id}")}")
    else
      # いいねしていなかった場合
      puts "いいねしてなかった"
      target_fav_relation.update!(tweet_id: "#{target_fav_relation.tweet_id} #{target_tweet_id}")
    end
    @fav_list = target_fav_relation
    puts "###action add_fav#####@fav_list.tweet_id######"
    puts @fav_list.tweet_id
    json_render(@fav_list)
  rescue => e
    puts "*****failed add_fav action error=>*****"
  end

  def grid_view
    @tweets = Tweet.all.order(created_at: "DESC")
    @fav_list = FavRelation.find_by(user_id: params[:user_id])
    json_render(@fav_list)
    puts "############@fav_list.tweet_id######"
    puts @fav_list.tweet_id
    rescue => e
      puts "grid_view action error"
  end

  def json_render(fav_list)
    @users = User.all
    @tweets_json = Hash.new
    data_records = Array.new
    @tweets = Tweet.all.order(created_at: "DESC")

    @tweets.each do |tweet|
      data_records <<
      {
        tweet_user: @users.find(tweet.tweet_user).user_name,
        tweet_user_id: tweet.tweet_user,
        tweet_id: tweet.id,
        fav_list: fav_list.tweet_id,
        content: tweet.content
      }
    end
    @tweets_json = {
      total: @tweets.length,
      records: data_records
    }
    render :json => @tweets_json
    rescue => e
      puts "*******json_render action error#{e}********"
  end
end