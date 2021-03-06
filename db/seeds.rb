require 'open-uri'
List.destroy_all
Movie.destroy_all
Bookmark.destroy_all

lists = [
  { api_id: 28, name: 'Action', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/1f4a3.png' },
  { api_id: 12, name: 'Adventure', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/2708.png' },
  { api_id: 16, name: 'Animation', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/1f58c.png' },
  { api_id: 35, name: 'Comedy', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/1f923.png' },
  { api_id: 80, name: 'Crime', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/1f46e.png' },
  { api_id: 99, name: 'Documentary', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/1f4fd.png' },
  { api_id: 18, name: 'Drama', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/1f3ad.png' },
  { api_id: 10751, name: 'Family', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/1f468-1f469-1f466.png' },
  { api_id: 14, name: 'Fantasy', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/1f9d9.png' },
  { api_id: 36, name: 'History', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/231b.png' },
  { api_id: 27, name: 'Horror', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/1f52a.png' },
  { api_id: 10402, name: 'Music', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/1f3b5.png' },
  { api_id: 9648, name: 'Mystery', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/1f50e.png' },
  { api_id: 10749, name: 'Romance', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/1f618.png' },
  { api_id: 878, name: 'Sci-Fi', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/1f47d.png' },
  { api_id: 10770, name: 'TV Movie', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/1f4fa.png' },
  { api_id: 53, name: 'Thriller', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/1f575.png' },
  { api_id: 10752, name: 'War', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/2694.png' },
  { api_id: 37, name: 'Western', url: 'https://images.emojiterra.com/openmoji/v12.2/128px/1f920.png' }
]

lists.each do |list_info|
  list = List.create!(name: list_info[:name])
  puts "Getting photo for #{list_info[:name]}..."
  file = URI.open(list_info[:url])
  list.photo.attach(io: file, filename: 'emoji.png', content_type: 'image/png')
end

(1..30).to_a.each do |digit|
  url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['MOVIE_API']}&page=#{digit}"
  response = JSON.parse(URI.open(url).read, { :symbolize_names => true })

  response[:results].each do |movie_hash|
    # create an instance with the hash
    movie = Movie.new(
      poster_url: "https://image.tmdb.org/t/p/w500" + movie_hash[:poster_path],
      title: movie_hash[:title],
      overview: movie_hash[:overview],
      rating: movie_hash[:vote_average]
    )
    if movie.save
      puts "#{movie} saved"
    end
  end
end

30.times do
  book = Bookmark.new(comment: 'Test fucking test', list: List.all.sample, movie: Movie.all.sample)
  p book if book.save
end
