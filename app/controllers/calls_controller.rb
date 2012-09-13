class CallsController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /calls
  # GET /calls.json
  def index
    @calls = Call.joins(:user).where( "group_id <> 1" ).order(" id DESC ").paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @calls }
    end
  end

  # GET /calls/admin
  # GET /calls/admin.json
  def admin
    @calls = Call.joins(:user).where( "group_id = 1" ).order(" id DESC ").paginate(:page => params[:page], :per_page => 20)

    respond_to do |format|
      format.html # admin.html.erb
      format.json { render json: @calls }
    end
  end

  # GET /calls/1
  # GET /calls/1.json
  def show
    @call = Call.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @call }
    end
  end

  # GET /calls/new
  # GET /calls/new.json
  def new
    @call = Call.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @call }
    end
  end

  # GET /calls/1/edit
  def edit
    @call = Call.find(params[:id])
  end

  # POST /calls
  # POST /calls.json
  def create
    @call = Call.new(params[:call])
    @call.user_id = current_user.id

    respond_to do |format|
      if @call.save
        format.html { redirect_to :call => "index", notice: 'Call was successfully created.' }
        format.json { render json: @call, status: :created, location: @call }
      else
        format.html { render action: "new" }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /calls/1
  # PUT /calls/1.json
  def update
    @call = Call.find(params[:id])
    @call.user_id = current_user.id

    respond_to do |format|
      if @call.update_attributes(params[:call])
        format.html { redirect_to :call => "index", notice: 'Call was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @call.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calls/1
  # DELETE /calls/1.json
  def destroy
    @call = Call.find(params[:id])
    @call.destroy

    respond_to do |format|
      format.html { redirect_to calls_url }
      format.json { head :no_content }
    end
  end
end
