class PokemonsController < ApplicationController
	def capture

		@pokemon = Pokemon.find(params[:id])
		@pokemon.trainer = current_trainer

		if @pokemon.save
			redirect_to root_path
		end

	end

	def damage

		destroyed  = false

		@pokemon = Pokemon.find(params[:id])

		@pokemon.health -= 10

		if @pokemon.health <= 0
			@pokemon.destroy
			destroyed = true
		end

		if destroyed
			redirect_to :back
		elsif @pokemon.save
			redirect_to :back
		else
			redirect_to :back
		end

	end


	def new
		@pokemon = Pokemon.new
	end


	def create
		@pokemon = Pokemon.create(pokemon_params)
		@pokemon.health = 100
		@pokemon.level = 1
		@pokemon.trainer = current_trainer
		if @pokemon.save
			redirect_to trainer_path(current_trainer)
		else
			redirect_to pokemons_new_path(flash[:error] = @pokemon.errors.full_messages.to_sentence)
		end
	end

	private

	def pokemon_params
		params.require(:pokemon).permit(:name)
	end






end
