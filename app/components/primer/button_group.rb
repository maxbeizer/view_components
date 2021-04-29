# frozen_string_literal: true

module Primer
  # Use `ButtonGroup` to render a series of buttons.
  class ButtonGroup < Primer::Component
    status :beta

    DEFAULT_TAG = :div
    TAG_OPTIONS = [:div, :span].freeze

    # Required list of buttons to be rendered.
    #
    # @param kwargs [Hash] The same arguments as <%= link_to_component(Primer::ButtonComponent) %> except for `variant` and `group_item`.
    renders_many :buttons, lambda { |**kwargs|
      kwargs[:group_item] = true
      kwargs[:variant] = @variant

      Primer::ButtonComponent.new(**kwargs)
    }

    # @example Default
    #
    #   <%= render(Primer::ButtonGroup.new) do |component| %>
    #     <% component.button { "Default" } %>
    #     <% component.button(scheme: :primary) { "Primary" } %>
    #     <% component.button(scheme: :danger) { "Danger" } %>
    #     <% component.button(scheme: :outline) { "Outline" } %>
    #     <% component.button(classes: "my-class") { "Custom class" } %>
    #   <% end %>
    #
    # @example Variants
    #
    #   <%= render(Primer::ButtonGroup.new(variant: :small)) do |component| %>
    #     <% component.button { "Default" } %>
    #     <% component.button(scheme: :primary) { "Primary" } %>
    #     <% component.button(scheme: :danger) { "Danger" } %>
    #     <% component.button(scheme: :outline) { "Outline" } %>
    #   <% end %>
    #
    #   <%= render(Primer::ButtonGroup.new(variant: :large)) do |component| %>
    #     <% component.button { "Default" } %>
    #     <% component.button(scheme: :primary) { "Primary" } %>
    #     <% component.button(scheme: :danger) { "Danger" } %>
    #     <% component.button(scheme: :outline) { "Outline" } %>
    #   <% end %>
    #
    # @param tag [Symbol] <%= one_of(Primer::ButtonGroup::TAG_OPTIONS) %>
    # @param variant [Symbol] <%= one_of(Primer::ButtonComponent::VARIANT_OPTIONS) %>
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(tag: DEFAULT_TAG, variant: Primer::ButtonComponent::DEFAULT_VARIANT, **system_arguments)
      @variant = variant
      @system_arguments = system_arguments
      @system_arguments[:tag] = fetch_or_fallback(TAG_OPTIONS, tag, DEFAULT_TAG)

      @system_arguments[:classes] = class_names(
        "BtnGroup",
        system_arguments[:classes]
      )
    end

    def render?
      buttons.any?
    end
  end
end
