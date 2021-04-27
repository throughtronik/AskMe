class UsersController < ApplicationController

  before_action :load_user, except: [:create, :index, :new]
  before_action :authorize_user, except: [:create, :index, :new, :show]

  def create
    redirect_to root_url, alert: 'Уже залогинены' if current_user.present?

    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Пользователь успешно зарегистрирован'
    else
      render :new
    end
  end

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: 'Уже залогинены' if current_user.present?

    @user = User.new
  end

  def edit
  end

  def destroy
    @user.destroy
    session[:user_id] = nil

    redirect_to root_url, notice: 'До скорых встреч!'
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    @new_question = @user.questions.build

    @questions_count = @questions.count
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions_count - @answers_count
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Данные обновлены'
    else
      render :edit
    end
  end

  private

  def authorize_user
    reject_user unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:bg_color, :email, :password, :password_confirmation, :name, :username, :avatar_url)
  end
end
