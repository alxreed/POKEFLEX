class PokemonsController < ApplicationController
  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]
  def index
    @url = ["https://eternia.fr/public/media//letsgo/artworks/divers/pokemon_partenaire.jpg", "http://getwallpapers.com/wallpaper/full/b/a/6/647483.jpg", "https://wallpapertag.com/wallpaper/full/7/e/5/189217-amazing-pokemon-hd-wallpaper-2560x1600-download-free.jpg", "https://avante.biz/wp-content/uploads/Wallpaper-Pokemon/Wallpaper-Pokemon-012.jpg", "http://www.wallpaperbetter.com/wallpaper/9/252/21/pokemon-background-for-1080P-wallpaper.jpg", "https://wallpaperplay.com/walls/full/d/2/5/101777.jpg", "https://images4.alphacoders.com/686/686185.jpg", "https://images8.alphacoders.com/723/723281.jpg", "https://wallpaperplay.com/walls/full/5/9/a/63005.jpg", "https://xshyfc.com/wp-content/uploads/data/2018/2/15/Pokemon-Wallpaper-Lugia-PIC-WPHR11496.jpg", "https://wallpapertag.com/wallpaper/full/0/9/c/142769-free-download-ghost-pokemon-wallpaper-1920x1200.jpg", "https://wallpaperplay.com/walls/full/9/7/3/280169.jpg", "https://i.pinimg.com/originals/53/d9/58/53d9581e5750e63e7a9c889b2d0cff50.jpg", "https://images5.alphacoders.com/389/389247.png"]
    if params["search"] == ""
      @pokemons = policy_scope(Pokemon).order(created_at: :desc)
    else
      @pokemons = policy_scope(Pokemon.joins(:race)).where("races.name LIKE ?", "%#{params["search"]}%")
    end
  end

  def show
    @url = ["https://eternia.fr/public/media//letsgo/artworks/divers/pokemon_partenaire.jpg", "http://getwallpapers.com/wallpaper/full/b/a/6/647483.jpg", "https://wallpapertag.com/wallpaper/full/7/e/5/189217-amazing-pokemon-hd-wallpaper-2560x1600-download-free.jpg", "https://avante.biz/wp-content/uploads/Wallpaper-Pokemon/Wallpaper-Pokemon-012.jpg", "http://www.wallpaperbetter.com/wallpaper/9/252/21/pokemon-background-for-1080P-wallpaper.jpg", "https://wallpaperplay.com/walls/full/d/2/5/101777.jpg", "https://images4.alphacoders.com/686/686185.jpg", "https://images8.alphacoders.com/723/723281.jpg", "https://wallpaperplay.com/walls/full/5/9/a/63005.jpg", "https://xshyfc.com/wp-content/uploads/data/2018/2/15/Pokemon-Wallpaper-Lugia-PIC-WPHR11496.jpg", "https://wallpapertag.com/wallpaper/full/0/9/c/142769-free-download-ghost-pokemon-wallpaper-1920x1200.jpg", "https://wallpaperplay.com/walls/full/9/7/3/280169.jpg", "https://i.pinimg.com/originals/53/d9/58/53d9581e5750e63e7a9c889b2d0cff50.jpg", "https://images5.alphacoders.com/389/389247.png"]
  end

  def new
    @pokemon = Pokemon.new
    authorize @pokemon
  end

  def create
    @race = Race.find(params[:pokemon][:race_id])
    @pokemon = Pokemon.new(pokemon_params)
    @pokemon.race = @race
    @pokemon.user = current_user
    authorize @pokemon
    if @pokemon.save
      redirect_to pokemon_path(@pokemon)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @pokemon.update(pokemon_params)
    if @pokemon.save
      redirect_to pokemon_path(@pokemon)
    else
      render :edit
    end
  end

  def destroy
    @pokemon.destroy
  end

  private

  def set_pokemon
    @pokemon = Pokemon.find(params[:id])
    authorize @pokemon
  end

  def pokemon_params
    params.require(:pokemon).permit(:name, :level, :price, :race_id)
  end
end
