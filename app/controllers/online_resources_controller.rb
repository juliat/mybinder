class OnlineResourcesController < ApplicationController
  # GET /online_resources
  # GET /online_resources.json
  def index
    @online_resources = OnlineResource.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @online_resources }
    end
  end

  # GET /online_resources/1
  # GET /online_resources/1.json
  def show
    @online_resource = OnlineResource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @online_resource }
    end
  end

  # GET /online_resources/new
  # GET /online_resources/new.json
  def new
    @online_resource = OnlineResource.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @online_resource }
    end
  end

  # GET /online_resources/1/edit
  def edit
    @online_resource = OnlineResource.find(params[:id])
  end

  # POST /online_resources
  # POST /online_resources.json
  def create
    @online_resource = OnlineResource.new(params[:online_resource])

    respond_to do |format|
      if @online_resource.save
        format.html { redirect_to url_for(@online_resource.resourceable) }
        format.json { render json: @online_resource, status: :created, location: @online_resource }
        format.js  #added
      else
        format.html { render action: "new" }
        format.json { render json: @online_resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /online_resources/1
  # PUT /online_resources/1.json
  def update
    @online_resource = OnlineResource.find(params[:id])

    respond_to do |format|
      if @online_resource.update_attributes(params[:online_resource])
        format.html { head :no_content }
        format.json { head :no_content }
        format.xml  { head :ok }
        format js # updated
      else
        format.html { head :no_content }
        format.json { render json: @online_resource.errors, status: :unprocessable_entity }
        format.xml  { render :xml => @online_resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /online_resources/1
  # DELETE /online_resources/1.json
  def destroy
    @online_resource = OnlineResource.find(params[:id])
    @online_resource.destroy

    respond_to do |format|
      format.html { redirect_to online_resources_url }
      format.json { head :no_content }
    end
  end
end
