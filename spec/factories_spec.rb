require 'rails_helper'

FactoryGirl.factories.map(&:name).each do |factory_name|
  describe "Factory for #{factory_name}" do
    it 'is valid' do
      factory = FactoryGirl.build(factory_name)
      if factory.respond_to?(:valid?)
        expect(factory).to be_valid, lambda {
          factory.errors.full_messages.join(',')
        }
      end
    end

    FactoryGirl.factories[factory_name]
               .definition
               .defined_traits.map(&:name).each do |trait_name|
      context "with trait #{trait_name}" do
        it 'is valid' do
          factory = FactoryGirl.build(factory_name, trait_name)

          if factory.respond_to?(:valid?)
            expect(factory).to be_valid, lambda {
              factory.errors.full_messages.join(',')
            }
          end
        end
      end
    end
  end
end
