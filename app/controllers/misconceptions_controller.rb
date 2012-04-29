class MisconceptionsController < ApplicationController
  # GET /misconceptions
  # GET /misconceptions.json
  def index
    @misconceptions = Misconception.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @misconceptions }
    end
  end

  # GET /misconceptions/1
  # GET /misconceptions/1.json
  def show
    @misconception = Misconception.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @misconception }
    end
  end

  # GET /misconceptions/new
  # GET /misconceptions/new.json
  def new
    @misconception = Misconception.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @misconception }
    end
  end

  # GET /misconceptions/1/edit
  def edit
    @misconception = Misconception.find(params[:id])
  end

  # POST /misconceptions
  # POST /misconceptions.json
  def create
    @misconception = Misconception.new(params[:misconception])

    respond_to do |format|
      if @misconception.save
        format.html { redirect_to @misconception, notice: 'Misconception was successfully created.' }
        format.json { render json: @misconception, status: :created, location: @misconception }
      else
        format.html { render action: "new" }
        format.json { render json: @misconception.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /misconceptions/1
  # PUT /misconceptions/1.json
  def update
    @misconception = Misconception.find(params[:id])

    respond_to do |format|
      if @misconception.update_attributes(params[:misconception])
        format.html { redirect_to @misconception, notice: 'Misconception was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @misconception.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /misconceptions/1
  # DELETE /misconceptions/1.json
  def destroy
    @misconception = Misconception.find(params[:id])
    @misconception.destroy

    respond_to do |format|
      format.html { redirect_to misconceptions_url }
      format.json { head :no_content }
    end
  end
end
