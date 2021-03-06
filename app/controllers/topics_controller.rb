class TopicsController < ApplicationController
    layout 'with_sidebar', :except => [:index, :new, :edit]
    
    before_filter :authenticate_user!
    load_and_authorize_resource :except => [:update_attribute_on_the_spot, :get_attribute_on_the_spot]

    can_edit_on_the_spot :check_access

    def check_access(object, field)
        authorize! :edit, object
    end
  
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.find(params[:id])
    @course = @topic.mod.unit.course
    @unit = @topic.mod.unit
    @mod = @topic.mod
    
    
    @online_resources = @topic.online_resources
    @resourceable_id = @topic.id

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(params[:topic])

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { render :text => params[:topic].values.first }
        format.json { head :no_content }
        format.xml  { head :ok }
      else
        format.html { render :text => params[:topic].values.first }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :no_content }
    end
  end
end
