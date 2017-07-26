require 'rails_helper'
require 'pry'

RSpec.describe TagsController do
  describe '#GET stats_for_all' do
    let(:product_tag) { FactoryGirl.create(:product_tag) }

    before(:each) do
      product_tag
      get :stats_for_all
    end

    it 'should return stats for all' do
      expect(response.code).to eq('200')
      expect(response.status).to eq(200)
      expect(response.message).to eq('OK')
      expect(JSON.parse(response.body).first['count']).to eq(1)
    end
  end

  describe '#GET stats for entity' do
    let(:article_type) { FactoryGirl.create(:article_e_type) }

    before(:each) do
      article_type
      get :stats_for_entity_type, entity_type: article_type.name
    end

    it 'should return stats for entity type' do
      json_response = JSON.parse response.body

      expect(response.status).to eq(200)
      expect(json_response.first['count']).to eq(1)
      expect(json_response.first['tag']).to eq('size')
    end
  end

  describe '#GET show' do
    let(:book_type) { FactoryGirl.create(:book_e_type) }

    context 'while inputting valida data' do
      before(:each) do
        book_type
        get :show, entity_type: book_type.name, entity_identifier: 'aaddd-2211'
      end

      it 'should return response for a single entity' do
        json_response = JSON.parse response.body

        expect(json_response['entity_type']).to eq('book')
        expect(json_response['entity']['entity_identifier']).to eq('aaddd-2211')
        expect(json_response['entity']['tags']).to be_a(Array)
      end
    end

    context 'while inputting invalid data' do
      before(:each) do
        book_type
        get :show, entity_type: book_type.name, entity_identifier: 'a'
      end

      it { expect(JSON.parse(response.body)['message']).to include('Data can be found') }
    end
  end

  describe '#POST create' do
    context 'while inpuuting a new entity' do
      before(:each) do
        request.env['HTTP_ACCEPT'] = 'application/json'
        post :create, entity_type: 'product-test', entity_identifier: '111--www--eee', tag: ['new-test', 's-bad']
      end

      it 'should create an entity' do
        json_response = JSON.parse response.body
        expect(json_response['message']).to include('EntityType with name product-test')
        expect(json_response['message']).to include('successfuly created/updated')
      end
    end

    context 'while inputting updating an entity' do
      before(:each) do
        request.env['HTTP_ACCEPT'] = 'application/json'
        post :create, entity_type: 'product-test', entity_identifier: '111--www--eee', tag: ['new-test', 's-bad']
      end

      it 'should replace existing entity tags' do
        names =  Tag.joins(entity_identifiers: :entity_type).where("entity_types.name = 'product-test'").pluck(:tag_name)
        expect(names).to include('new-test')
        expect(names).to include('s-bad')

        post :create, entity_type: 'product-test', entity_identifier: '111--www--eee', tag: ['bad-test', 'something-bad']
        new_names = Tag.joins(entity_identifiers: :entity_type).where("entity_types.name = 'product-test'").pluck(:tag_name)

        expect(new_names).to include('bad-test')
        expect(new_names).to include('something-bad')
      end
    end
  end

  describe '#DELETE destroy' do
    let(:book_type) { FactoryGirl.create(:book_e_type) }

    context 'while entity tpe present in the database' do
      before(:each) do
        book_type
        delete :destroy, entity_type: book_type.name, entity_identifier: 'aaddd-2211'
      end

      it 'should destroy the entity' do
        json_response = JSON.parse response.body

        expect(response.status).to eq(200)
        expect(json_response['message']).to eq('Entity Succesfully Deelted')
      end
    end

    context 'while there is no entity type in the dataase' do
      before(:each) do
        delete :destroy, entity_type: 'test', entity_identifier: 'aaddd-2211'
      end

      it 'should return 400' do
        json_response = JSON.parse response.body

        expect(json_response['message']).to eq('RecordNotFound')
        expect(response.status).to eq(400)
      end
    end
  end
end
