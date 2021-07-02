# frozen_string_literal: true

module Primer
  # Use `HiddenTextExpander` to indicate and toggle hidden text.
  class HiddenTextExpander < Primer::Component
    # @example Default
    #   <%= render(Primer::HiddenTextExpander.new("aria-label": "No effect")) %>
    #
    # @example Inline
    #   <%= render(Primer::HiddenTextExpander.new(inline: true, "aria-label": "No effect")) %>
    #
    # @example Styling the button
    #   <%= render(Primer::HiddenTextExpander.new("aria-label": "No effect", button_arguments: { p: 1, classes: "custom-class" })) %>
    #
    # @param inline [Boolean] Whether or not the expander is inline.
    # @param button_arguments [Hash] <%= link_to_system_arguments_docs %> for the button element.
    # @param system_arguments [Hash] <%= link_to_system_arguments_docs %>
    def initialize(inline: false, button_arguments: {}, **system_arguments)
      @system_arguments = system_arguments
      @button_arguments = button_arguments

      @system_arguments[:tag] = :span
      @system_arguments[:classes] = class_names(
        "hidden-text-expander",
        @system_arguments[:classes],
        "inline" => inline
      )

      aria_label = system_arguments[:"aria-label"] || system_arguments.dig(:aria, :label) || @aria_label
      if aria_label.present?
        @button_arguments[:"aria-label"] = aria_label
        @system_arguments[:aria]&.delete(:label)
      end

      @button_arguments[:classes] = class_names(
        "ellipsis-expander",
        button_arguments[:classes]
      )
    end

    def call
      render(Primer::BaseComponent.new(**@system_arguments)) do
        render(Primer::HellipButton.new(**@button_arguments))
      end
    end
  end
end
