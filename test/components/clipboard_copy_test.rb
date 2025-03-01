# frozen_string_literal: true

require "test_helper"

class PrimerClipboardCopyTest < Minitest::Test
  include Primer::ComponentTestHelpers

  def test_renders_simple
    render_inline Primer::ClipboardCopy.new(value: "my-branch-name", "aria-label": "Copy branch name to clipboard")

    assert_selector("clipboard-copy[data-view-component][value=\"my-branch-name\"]") do
      assert_selector("svg.octicon.octicon-copy")
      assert_selector("svg.octicon.octicon-check.color-fg-success", visible: false)
    end
  end

  def test_renders_with_text_contents
    render_inline Primer::ClipboardCopy.new(value: "my-branch-name", "aria-label": "Copy branch name to clipboard") do
      "Click to copy!"
    end

    assert_selector("clipboard-copy[data-view-component][value=\"my-branch-name\"]") do |node|
      assert_equal(node.text.strip, "Click to copy!")
    end
  end

  def test_renders_with_for
    render_inline Primer::ClipboardCopy.new(for: "element-id", "aria-label": "Copy branch name to clipboard")

    assert_selector("clipboard-copy[data-view-component][for=\"element-id\"]") do
      assert_selector("svg.octicon.octicon-copy")
      assert_selector("svg.octicon.octicon-check.color-fg-success", visible: false)
    end
  end
end
