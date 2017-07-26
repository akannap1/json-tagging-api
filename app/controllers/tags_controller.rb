class TagsController < ApplicationController
  # before_action :set_tag, only: %i[show edit update destroy]
  before_action :set_entity_type, only: %i[index show destroy]
  skip_before_filter :verify_authenticity_token

  # GET /tags
  # GET /tags.json
  def stats_for_entity_type ## retreive stats for an enitity
    tag_names = Tag.joins(entity_identifiers: :entity_type).where("entity_types.name = '#{tag_params['entity_type']}'").pluck(:tag_name)
    tag_names = tag_names.each_with_object(Hash.new(0)) { |elem, result| result[elem] += 1 }
    render json: tag_names.each_with_object([]) { |(key, value), result| result << { tag: key, count: value } }
  end

  # GET /tags/1
  # GET /tags/1.json
  def show ## retreive stat
    unique_identifier = @set_entity_type.entity_identifiers.find_by!(entity_id: tag_params['entity_identifier'])
    render json: { entity: { tags:  unique_identifier.tags.pluck(:tag_name),
                             entity_identifier: unique_identifier.entity_id }, entity_type: @set_entity_type.name }, status: 200
  rescue ActiveRecord::RecordNotFound => error
    render json: { message: 'Data can be found in our database' }, status: 404
  end

  # POST /tags
  # POST /tags.json
  def create
    entity_identifier = EntityIdentifier.where(entity_id: tag_params['entity_identifier']).first_or_initialize
    entity_identifier.tags = tag_params['tag'].each_with_object([]) do |elem, res|
      res << Tag.find_or_create_by!(tag_name: elem)
    end

    entity_identifier.save!
    entity_type = EntityType.where(name: tag_params['entity_type']).first_or_initialize
    entity_type.entity_identifiers << entity_identifier unless entity_type.entity_identifiers.include?(entity_identifier)
    entity_type.save!
    render json: { message: "EntityType with name #{entity_type.name}  successfuly created/updated" }, status: 201
  rescue ActiveRecord::RecordInvalid => error
    render json: { message: error }, status: 400
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @set_entity_type.destroy!
    render json: { message: 'Entity Succesfully Deelted' }, status: 200
  end

  def stats_for_all
    all_tags = Tag.all.pluck(:tag_name)
    all_tags = all_tags.each_with_object(Hash.new(0)) { |element, result| result[element] += 1 }
    render json: all_tags.each_with_object([]) { |(key, value), result| result << { tag: key, count: value } }
  end

  private

  # Use callbacks to share common setup or constraints between actions.

  def set_entity_type
    @set_entity_type = EntityType.find_by!(name: tag_params['entity_type'])
  rescue ActiveRecord::RecordNotFound => error
    render json: { message: 'RecordNotFound' }, status: 400
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tag_params
    params.permit(:entity_type, :entity_identifier, tag: [])
  end
end
