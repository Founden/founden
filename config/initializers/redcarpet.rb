require 'redcarpet'
require 'redcarpet/socialable'

# Our Redcarpet render class
class Founden::MarkdownRender < Redcarpet::Render::HTML
  include Redcarpet::Socialable::Mentions

  # Regexp to match the mentions
  def mention_regexp; '@id\:([\d]+)@' end

  # Template to render a mention
  def mention_template(user_name)
    '<span class="mention">%s</span>' % user_name
  end

  # Validates a mention
  def mention?(user_id)
    if user = User.find_by(:id => user_id)
      user.full_name
    end
  end
end

Founden::Application.config.markdown = Redcarpet::Markdown.new(
  Founden::MarkdownRender.new({
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
