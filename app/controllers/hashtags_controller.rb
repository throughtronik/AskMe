class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by(tag: params[:id])
  end
end
