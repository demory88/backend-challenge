class UsersController < ActionController::Base
  protect_from_forgery with: :exception

  layout "application"

  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
    user = User.find params[:id]
    @friends = User.where(id: user.friends)
    remove = @user.friends << @user.id
    @all_users = User.where.not(id: remove)

    # self-contained search so users don't have to leave their page to find experts
    if params[:search].present?
      # find users who match the searched for topics
      matches = User.where('tags LIKE ?', "%#{params[:topic]&.strip&.downcase}%")
      @matches = matches
      @topic = params[:topic]

      # this is six degrees of separation, but without Kevin Bacon
      @connections = []

      # now we look for our user in a widening circle of friends and connections
      matches.uniq.each do |match|
        subpath = []
        if match.friends.include?(current_user.id)
          # adding this because, as a user, I'd want to know if an existing friend was an expert in the topic of interest
          subpath << match
        else
          # This would be far cleaner as a recursive function- just calling itself ad infinitum until if found a connection, but I'm up against time and I don't want to cheat
          match.friends.each do |friend_id|
            friend = User.find friend_id
            if friend == current_user
              subpath << match
              subpath << friend
            elsif friend.friends | current_user.friends
              secondary = User.find (friend.friends | current_user.friends).first
              subpath << match
              subpath << friend
              subpath << secondary
            end
          end
        end
        subpath << current_user
        @connections << subpath
      end
    end
  end

  def make_friends
    user = User.find params[:user]
    new_friends = params[:friend_list].reject { |f| f.empty? }
    user.friends = user.friends + new_friends.map { |f| f.to_i }
    user.save

    friends = User.where(id: user.friends)

    friends.each do |friend|
      friend.friends << user.id
      friend.friends = friend.friends.uniq
      friend.save
    end
    redirect_to :back, notice: "Your friends list is growing!"
  end

  def find_experts

    @users = User.all
  end

end
