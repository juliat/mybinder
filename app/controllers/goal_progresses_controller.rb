class GoalProgressesController < ApplicationController

  # load_and_authorize_resource, :except => [:update_attribute_on_the_spot]
  can_edit_on_the_spot

  # GET /goal_progresses
  # GET /goal_progresses.json
  def index
    @goals = Goal.in_sequential_order.includes([:goal_progresses])
    @goals = Goal.sorted(@goals)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @goal_progresses }
    end
  end

  # GET /goal_progresses/1
  # GET /goal_progresses/1.json
  def show
    @goal_progress = GoalProgress.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @goal_progress }
    end
  end

  # GET /goal_progresses/new
  # GET /goal_progresses/new.json
  def new
    @goal_progress = GoalProgress.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @goal_progress }
    end
  end

  # GET /goal_progresses/1/edit
  def edit
    @goal_progress = GoalProgress.find(params[:id])
  end

  # POST /goal_progresses
  # POST /goal_progresses.json
  def create
    @goal_progress = GoalProgress.new(params[:goal_progress])

    respond_to do |format|
      if @goal_progress.save
        format.html { redirect_to @goal_progress, notice: 'Goal progress was successfully created.' }
        format.json { render json: @goal_progress, status: :created, location: @goal_progress }
      else
        format.html { render action: "new" }
        format.json { render json: @goal_progress.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /goal_progresses/1
  # PUT /goal_progresses/1.json
  def update
    @goal_progress = GoalProgress.find(params[:id])

    respond_to do |format|
      if @goal_progress.update_attributes(params[:goal_progress])
        format.html { redirect_to @goal_progress, notice: 'Goal progress was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @goal_progress.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /goal_progresses/1
  # DELETE /goal_progresses/1.json
  def destroy
    @goal_progress = GoalProgress.find(params[:id])
    @goal_progress.destroy

    respond_to do |format|
      format.html { redirect_to goal_progresses_url }
      format.json { head :no_content }
    end
  end
end
