class OutgoingsController < ApplicationController
  before_action :set_outgoing, only: [:show, :edit, :update, :destroy]

  # GET /outgoings
  # GET /outgoings.json
  def index
    @outgoings = Outgoing.all
  end

  # GET /outgoings/1
  # GET /outgoings/1.json
  def show
  end

  # GET /outgoings/new
  def new
    @outgoing = Outgoing.new
  end

  # GET /outgoings/1/edit
  def edit
  end

  # POST /outgoings
  # POST /outgoings.json
  def create
    @outgoing = Outgoing.new(outgoing_params)

    respond_to do |format|
      if @outgoing.save
        format.html { redirect_to @outgoing, notice: 'Outgoing was successfully created.' }
        format.json { render :show, status: :created, location: @outgoing }
      else
        format.html { render :new }
        format.json { render json: @outgoing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /outgoings/1
  # PATCH/PUT /outgoings/1.json
  def update
    respond_to do |format|
      if @outgoing.update(outgoing_params)
        format.html { redirect_to @outgoing, notice: 'Outgoing was successfully updated.' }
        format.json { render :show, status: :ok, location: @outgoing }
      else
        format.html { render :edit }
        format.json { render json: @outgoing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /outgoings/1
  # DELETE /outgoings/1.json
  def destroy
    @outgoing.destroy
    respond_to do |format|
      format.html { redirect_to outgoings_url, notice: 'Outgoing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_outgoing
      @outgoing = Outgoing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def outgoing_params
      params.require(:outgoing).permit(:note, :date, :sum, :category_id, :pocket_id, :user_id)
    end
end
