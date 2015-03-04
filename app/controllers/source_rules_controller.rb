class SourceRulesController < ApplicationController
  before_action :set_source_rule, only: [:show, :edit, :update, :destroy]

  # GET /source_rules
  # GET /source_rules.json
  def index
    @source_rules = SourceRule.all
  end

  # GET /source_rules/1
  # GET /source_rules/1.json
  def show
  end

  # GET /source_rules/new
  def new
    @source = Source.find(params[:source_id])
    @source_rule = @source.source_rules.build
  end

  # GET /source_rules/1/edit
  def edit
  end

  # POST /source_rules
  # POST /source_rules.json
  def create
    @source = Source.find(params[:source_id])
    @source_rule = SourceRule.new(source_rule_params)
    @source_rule.source_id = params[:source_id]

    respond_to do |format|
      if @source_rule.save
        format.html { redirect_to @source, notice: 'Source rule was successfully created.' }
        format.json { render :show, status: :created, location: @source_rule }
      else
        format.html { render :new }
        format.json { render json: @source_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /source_rules/1
  # PATCH/PUT /source_rules/1.json
  def update
    respond_to do |format|
      if @source_rule.update(source_rule_params)
        format.html { redirect_to @source_rule, notice: 'Source rule was successfully updated.' }
        format.json { render :show, status: :ok, location: @source_rule }
      else
        format.html { render :edit }
        format.json { render json: @source_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /source_rules/1
  # DELETE /source_rules/1.json
  def destroy
    @source_rule.destroy
    respond_to do |format|
      format.html { redirect_to source_rules_url, notice: 'Source rule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_source_rule
      @source_rule = SourceRule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def source_rule_params
      params.require(:source_rule).permit(:source, :name, :action, :value)
    end
end
