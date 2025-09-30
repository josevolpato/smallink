require "securerandom"

class LinksController < ApplicationController
  before_action :set_link, only: %i[ show ]
  before_action :set_link_follow, only: %i[ follow ]

  # GET /
  def new
    @link = Link.new
  end

  # POST /
  def create
    @link = Link.new(link_params)
    @link.shortened = generate_shortened

    respond_to do |format|
      if @link.save
        @notice = "Link criado com sucesso: "
        format.html { render :new, status: :created }
        format.json { render json: @link, status: :created }
      else
        @link.shortened = nil
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /links/1 or /links/1.json
  def show
  end

  # GET /hX9KQZ8i
  def follow
    if !@link.nil?
      redirect_to "https://" + @link.url, allow_other_host: true
    else
      render file: "#{Rails.root}/public/404.html", status: :not_found, layout: false
    end
  end

  # GET /links or /links.json
  def index
    @links = Link.all
  end

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
