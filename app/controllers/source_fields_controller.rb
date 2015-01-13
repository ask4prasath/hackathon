class SourceFieldsController < ApplicationController
  before_action :set_source_field, only: [:show, :edit, :update, :destroy]

  # GET /source_fields
  # GET /source_fields.json
  def index
    @source_fields = SourceField.all
  end

  # GET /source_fields/1
  # GET /source_fields/1.json
  def show
  end

  # GET /source_fields/new
  def new
    @source_field = SourceField.new
  end

  # GET /source_fields/1/edit
  def edit
  end

  # POST /source_fields
  # POST /source_fields.json
  def create
    @source_field = SourceField.new(source_field_params)

    respond_to do |format|
      if @source_field.save
        format.html { redirect_to @source_field, notice: 'Source field was successfully created.' }
        format.json { render :show, status: :created, location: @source_field }
      else
        format.html { render :new }
        format.json { render json: @source_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /source_fields/1
  # PATCH/PUT /source_fields/1.json
  def update
    respond_to do |format|
      if @source_field.update(source_field_params)
        format.html { redirect_to @source_field, notice: 'Source field was successfully updated.' }
        format.json { render :show, status: :ok, location: @source_field }
      else
        format.html { render :edit }
        format.json { render json: @source_field.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /source_fields/1
  # DELETE /source_fields/1.json
  def destroy
    @source_field.destroy
    respond_to do |format|
      format.html { redirect_to source_fields_url, notice: 'Source field was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_source_field
      @source_field = SourceField.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def source_field_params
      params.require(:source_field).permit(:key_name, :field_type, :source_id)
    end
end
