# frozen_string_literal: true

require "test_helper"

class PrimerAutoCompleteItemTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_item_with_correct_attributes
    render_inline(Primer::Beta::AutoComplete::Item.new(value: "foo")) { "Item" }

    assert_selector("li[role=\"option\"][data-autocomplete-value=\"foo\"].ActionList-item", text: "Item")
  end

  def test_renders_selected_item
    render_inline(Primer::Beta::AutoComplete::Item.new(value: "foo", selected: true)) { "Item" }

    assert_selector("li[role=\"option\"][data-autocomplete-value=\"foo\"][aria-selected=\"true\"].ActionList-item", text: "Item")
  end

  def test_renders_disabled_item
    render_inline(Primer::Beta::AutoComplete::Item.new(value: "foo", disabled: true)) { "Item" }

    assert_selector("li[role=\"option\"][data-autocomplete-value=\"foo\"][aria-disabled=\"true\"].ActionList-item", text: "Item")
  end
end
