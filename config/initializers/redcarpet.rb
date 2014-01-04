require 'redcarpet'

Founden::Application.config.markdown = Redcarpet::Markdown.new(
  Redcarpet::Render::HTML.new({
    :filter_html => true,
    :no_images => true,
    :no_links => false,
    :no_styles => true,
    :safe_links_only => true,
    :with_toc_data => false,
    :hard_wrap => false,
    :prettify => false,
    :xhtml => true,
    # :link_attributes => {}
  }),
  {
    :autolink => true,
    :fenced_code_blocks => true,
    :filter_html => true,
    # :hard_wrap => true,
    # :prettify => true,
    # :lax_spacing => true,
    :no_images => true,
    :no_intra_emphasis => true,
    :no_links => true,
    :no_styles => true,
    :safe_links_only => true,
    :space_after_headers => true,
    :strikethrough => true,
    # :tables => true,
    # :with_toc_data => true,
    :xhtml => true,
    :disable_indented_code_blocks => true,
    :superscript => true,
    :underline => true,
    # :highlight => true,
    # :quote => true,
    # :footnotes => true
  }
)
