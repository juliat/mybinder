class DetailedActivitiesController < ApplicationController
  # GET /detailed_activities
  # GET /detailed_activities.json
  def index
    @detailed_activities = DetailedActivity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @detailed_activities }
    end
  end

  # GET /detailed_activities/1
  # GET /detailed_activities/1.json
  def show
    @detailed_activity = DetailedActivity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @detailed_activity }
    end
  end

  # GET /detailed_activities/new
  # GET /detailed_activities/new.json
  def new
    @detailed_activity = DetailedActivity.new
    @detailed_activity.activity_id = params[:activity_id] unless params[:activity_id].nil?
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @detailed_activity }
    end
  end

  # GET /detailed_activities/1/edit
  def edit
    @detailed_activity = DetailedActivity.find(params[:id])
  end

  # POST /detailed_activities
  # POST /detailed_activities.json
  def create
    params[:detailed_activity].delete("_destroy")
    @detailed_activity = DetailedActivity.new(params[:detailed_activity])

    respond_to do |format|
      if @detailed_activity.save
        format.html { redirect_to url_for(@detailed_activity.activity) }
        format.json { render json: @detailed_activity, status: :created, location: @detailed_activity }
        format.js  #added
      else
        format.html { render action: "new" }
        format.json { render json: @detailed_activity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /detailed_activities/1
  # PUT /detailed_activities/1.json
  def update
    @detailed_activity = DetailedActivity.find(params[:id])

    respond_to do |format|
      if @detailed_activity.update_attributes(params[:detailed_activity])
        format.html { head :no_content }
        format.json { head :no_content }
        format.xml  { head :ok }
      else
        format.html { head :no_content }
        format.json { render json: @detailed_activity.errors, status: :unprocessable_entity }
        format.xml  { render :xml => @detailed_activity.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /detailed_activities/1
  # DELETE /detailed_activities/1.json
  def destroy
    @detailed_activity = DetailedActivity.find(params[:id])
    @detailed_activity.destroy

    respond_to do |format|
      format.html { redirect_to detailed_activities_url }
      format.json { head :no_content }
    end
  end
end
