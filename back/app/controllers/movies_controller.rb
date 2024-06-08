require 'httparty'

class MoviesController < ApplicationController
  skip_before_action :authenticate_user!

  def index ;end

  def show
    movie_data = MovieFetcher.movie_data_detail(params[:id])
    Rails.logger.debug("kkkkkkkk#{movie_data}")
    @video_id = fetch_youtube_video(movie_data["original_title"])
    @keywords = get_keywords(movie_data["id"])
    Rails.logger.debug("dddddddd#{@video_id}")
    @movie = MovieSaverService.save_movie(movie_data, @video_id,@keywords)
  end

  def random
    language = params[:language]
    selected_runtime = params[:selected_runtime]
    keyword = params[:keyword]
    genre = params[:genre]

    if keyword == "now_playing"
      @movie_data = NowPlayingMovie.random_playing_movie(language: language,selected_runtime: selected_runtime)
    elsif params.empty? || params.nil?
      @movie_data = MovieRandom.get_random_movie
    else
      Rails.logger.debug("ここを見てくれ！！！！！！#{selected_runtime}")
      @movie_data = SelectRandomMovie.select_random_movie(language, selected_runtime, keyword, genre)
    end

    Rails.logger.debug("ここを見てくれ！！！！！！#{@movie_data}")
    if @movie_data.present?
      redirect_to movie_path(@movie_data)
    else
      flash.now[:alert] = '条件に合う映画が見つかりませんでした。'
      redirect_to movies_path
    end
  end

  private

  def get_keywords(movie_id)
    api_key = Rails.application.credentials.api_key[:tmdb]
    url = "https://api.themoviedb.org/3/movie/#{movie_id}/keywords?api_key=#{api_key}"
    response = HTTParty.get(url)
    keywords = JSON.parse(response.body)['keywords']
    keywords
  end

  def fetch_youtube_video(title)
    Rails.logger.debug(title)
    youtube_search_query = "#{title} 映画 予告"
    YoutubeService.search_videos(youtube_search_query)
  end
end
