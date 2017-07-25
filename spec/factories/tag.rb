FactoryGirl.define do
  factory :product_tag, class: Tag do
    id '1'
    tag_name 'Product-test'
  end

  factory :article_e_type, class: EntityType do
    id '1'
    name 'test-article'
    after(:build) do |job|
      job.entity_identifiers << FactoryGirl.build(:article_identifier)
    end
  end

  factory :article_identifier, class: EntityIdentifier do
    id '1'
    entity_id '111--222--33--44'
    after(:build) do |job|
      job.tags << FactoryGirl.build(:article_tag)
    end
  end

  factory :article_tag, class: Tag do
    id '7'
    tag_name 'size'
  end

  factory :book_e_type, class: EntityType do
    id '2'
    name 'book'
    after(:build) do |job|
      job.entity_identifiers << FactoryGirl.build(:book_identifier)
    end
  end

  factory :book_identifier, class: EntityIdentifier do
    id '3'
    entity_id 'aaddd-2211'

    after(:build) do |job|
      job.tags << FactoryGirl.build(:book_tag)
    end
  end

  factory :book_tag, class: Tag do
    id '4'
    tag_name 'price'
  end
end
