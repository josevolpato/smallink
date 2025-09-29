require "securerandom"

class LinksController < ApplicationController
  before_action :set_link, only: %i[ show ]
  before_action :set_link_follow, only: %i[ follow ]

  # GET /links or /links.json
  def index
    @links = Link.all
  end

  # GET /links/1 or /links/1.json
  def show
  end

  def follow
    if !@link.nil?
      redirect_to "https://" + @link.url, allow_other_host: true
    else
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
  end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links or /links.json
  def create
    @link = Link.new(link_params)
    @link.shortened = generate_shortened

    respond_to do |format|
      if @link.save
        format.html { redirect_to @link, notice: "Link was successfully created." }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @link, notice: "Link was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  # def destroy
  #   @link.destroy!

  #   respond_to do |format|
  #     format.html { redirect_to links_path, notice: "Link was successfully destroyed.", status: :see_other }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params.expect(:id))
    end

    def set_link_follow
      @link = Link.where(shortened: params.expect(:shortened)).first
    end

    # Only allow a list of trusted parameters through.
    def link_params
      params.expect(link: [ :url ])
    end

    def generate_shortened
      SecureRandom.alphanumeric(8)
    end
end
