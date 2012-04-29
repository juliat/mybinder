class ModsController < ApplicationController
  # GET /mods
  # GET /mods.json
  def index
    @mods = Mod.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mods }
    end
  end

  # GET /mods/1
  # GET /mods/1.json
  def show
    @mod = Mod.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mod }
    end
  end

  # GET /mods/new
  # GET /mods/new.json
  def new
    @mod = Mod.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mod }
    end
  end

  # GET /mods/1/edit
  def edit
    @mod = Mod.find(params[:id])
  end

  # POST /mods
  # POST /mods.json
  def create
    @mod = Mod.new(params[:mod])

    respond_to do |format|
      if @mod.save
        format.html { redirect_to @mod, notice: 'Mod was successfully created.' }
        format.json { render json: @mod, status: :created, location: @mod }
      else
        format.html { render action: "new" }
        format.json { render json: @mod.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mods/1
  # PUT /mods/1.json
  def update
    @mod = Mod.find(params[:id])

    respond_to do |format|
      if @mod.update_attributes(params[:mod])
        format.html { redirect_to @mod, notice: 'Mod was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mod.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mods/1
  # DELETE /mods/1.json
  def destroy
    @mod = Mod.find(params[:id])
    @mod.destroy

    respond_to do |format|
      format.html { redirect_to mods_url }
      format.json { head :no_content }
    end
  end
end
