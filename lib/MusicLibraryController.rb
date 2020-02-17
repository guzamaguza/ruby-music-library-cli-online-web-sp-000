require 'pry'

class MusicLibraryController
  attr_accessor :path
  extend Concerns::Findable

  def initialize(path='./db/mp3s')
    @path = path
    music_importer = MusicImporter.new(path)
    music_importer.import
  end

  def call
    puts "Welcome to your music library!"
    puts "To list all of your songs, enter 'list songs'."
    puts "To list all of the artists in your library, enter 'list artists'."
    puts "To list all of the genres in your library, enter 'list genres'."
    puts "To list all of the songs by a particular artist, enter 'list artist'."
    puts "To list all of the songs of a particular genre, enter 'list genre'."
    puts "To play a song, enter 'play song'."
    puts "To quit, type 'exit'."
    puts "What would you like to do?"

    input = gets.strip
    if input != 'exit'

      case input
         when "list songs"
           list_songs
         when "list artists"
           list_artists
         when "list genres"
           list_genres
         when "list artist"
           list_songs_by_artist
         when "list genre"
           list_songs_by_genre
         when "play song"
           play_song
         end
     end
   end

   def list_songs
     Song.all.sort{|a,b| a.name <=> b.name}.each_with_index do |song, i|
        puts "#{i+1}. #{song.artist.name} - #{song.name} - #{song.genre.name}"
        #"1. Thundercat - For Love I Come - dance"
     end
   end

   def list_artists
     Artist.all.sort{|a,b| a.name <=> b.name}.each_with_index do |artist, i|
        puts "#{i+1}. #{artist.name}"
       #"1. Action Bronson"
     end
   end

   def list_genres
     Genres.all.sort{|a,b| a.name <=> b.name}.each_with_index do |genre, i|
       puts "#{i+1}. #{genre.name}"
       #"1. country"
     end
   end

   def list_songs_by_artist
     puts "Please enter the name of an artist:"
     input = gets.strip

     if Artist.find_by_name(input)
       Artist.find_by_name(input).songs.sort{|a,b| a.name <=> b.name}.each_with_index do |song, i|
         puts "#{i+1}. #{song.name} - #{song.genre.name}"
         #"1. Green Aisles - country"
       end
     end
   end

   def list_songs_by_genre
     puts "Please enter the name of a genre:"
     input = gets.strip

     if Genre.find_by_name(input)
       Genre.find_by_name(input).songs.sort{|a,b| a.name <=> b.name}.each_with_index do |song, i|
         puts "#{i+1}. #{song.name} - #{song.genre.name}"
         #"1. Real Estate - It's Real"
       end
     end
   end

   def play_song
     puts "#{self.list_songs}"
     puts "Which song number would you like to play?"
     input = gets.strip
     if input < Song.length && input > 0
         if Song.find_by_name(input)
            puts "Playing #{Song.find_by_name(input).name} by #{Song.find_by_name(input).artist.name}"
         end
      end
   end

end
