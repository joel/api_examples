# frozen_string_literal: true

require "rails_helper"

RSpec.describe User do
  context "with validations" do
    it "is valid with valid attributes" do
      expect(build(:user)).to be_valid
    end
  end

  context "when create or update" do
    let(:attributes) { attributes_for(:user).merge(id:) }
    let(:instance) do
      described_class.find_by(id:) || described_class.new
    end

    context "when create" do
      let(:id) { ArUlid.configuration.generator.generate_id }

      it do
        expect do
          instance.update(attributes)
        end.to change(described_class, :count).by(1)
      end

      it "does change the id" do
        expect do
          instance.update(attributes)
        end.to change(instance, :id).to(id)
      end
    end

    context "when update" do
      before { id }

      let(:id) { create(:user).id }

      it do
        expect do
          instance.update(attributes)
        end.not_to change(described_class, :count)
      end
    end
  end
end
