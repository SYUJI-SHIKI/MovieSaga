class Movie < ApplicationRecord
  serialize :keywords, JSON

  def save_with_data(movie_data, video_id, keywords)
    self.assign_attributes(
      title: movie_data[:title],
      overview: movie_data[:overview],
      postpath: movie_data[:postpath],
      runtime: movie_data[:runtime],
      language: movie_data[:language],
      status: movie_data[:status],
      release_date: movie_data[:release_date],
      genres: movie_data[:genres],
      # youtube_trailer_id: video_id["id"]["videoId"],
      keywords: keywords
    )
    save!
  end
end
