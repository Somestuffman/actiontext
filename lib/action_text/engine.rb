# frozen_string_literal: true

require "rails/engine"

module ActionText
  class Engine < Rails::Engine
    isolate_namespace ActionText
    config.eager_load_namespaces << ActionText

    initializer "action_text.attribute" do
      ActiveSupport.on_load(:active_record) do
        include ActionText::Attribute
      end
    end

    initializer "action_text.active_storage_extension" do
      ActiveSupport.on_load(:active_storage_blob) do
        include ActionText::Attachable

        def previewable_attachable?
          representable?
        end
      end
    end

    initializer "action_text.helper" do
      ActiveSupport.on_load(:action_controller_base) do
        helper ActionText::Engine.helpers
      end
    end
  end
end
