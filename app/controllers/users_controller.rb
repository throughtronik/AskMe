class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Vadim',
        username: 'installero',
        avatar_url: 'https://www.bikkinpanda.com/wp-content/uploads/2018/04/gravatar-1-810x450.png'
      ),
      User.new(
        id: 2,
        name: 'Misha',
        username: 'aristofun'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Vadim',
      username: 'installero',
      avatar_url: 'https://www.bikkinpanda.com/wp-content/uploads/2018/04/gravatar-1-810x450.png'
    )

     @questions = [
      Question.new(text: 'How r u?', created_at: Date.parse('27.03.2016')),
      Question.new(text: 'What is the sense of life?', created_at: Date.parse('27.03.2016'))
    ]

    @new_question = Question.new
  end
end
