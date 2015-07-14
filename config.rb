# Time.zone = "UTC"

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  # blog.prefix = "blog"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  blog.sources = "posts/{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  # blog.layout = "layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  blog.default_extension = ".md"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  # blog.page_link = "page/{num}"
end

page "/sitemap.xml", layout: false

###
# Compass
###

# Change Compass configuration
compass_config do |config|
  config.output_style = :compact
end

# Change Compass configuration
# config :development do
  compass_config do |config|
    config.sass_options = { debug_info: false }
  end
# end

###
# Page options, layouts, aliases and proxies
###

# Slim settings
Slim::Engine.set_default_options :pretty => true, :shortcut => {
  '#' => {:tag => 'div', :attr => 'id'},
  '.' => {:tag => 'div', :attr => 'class'},
  '&' => {:tag => 'input', :attr => 'type'}
}

# Markdown settings
set :markdown, :tables => true, :autolink => true, :gh_blockcode => true, :fenced_code_blocks => true, :with_toc_data => true
set :markdown_engine, :redcarpet

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", layout: false
#
# With alternative layout
# page "/path/to/file.html", layout: :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

###
# Site Settings
###
# Set site setting, used in helpers / sitemap.xml / feed.xml.
set :site_url, 'https://integros.com'
set :site_author, 'Integros Ltd.'
set :site_title, 'Integros Video Layer'
set :site_description, 'Integros Video Layer'
# Select the theme from bootswatch.com.
# If false, you can get plain bootstrap style.
# set :theme_name, 'paper'
set :theme_name, false
# set @analytics_account, like "XX-12345678-9"
@analytics_account = false

# Asset Settings
set :css_dir, 'css'
set :js_dir, 'js'
set :images_dir, 'images'

after_configuration do
  @bower_config = JSON.parse(IO.read("#{root}/.bowerrc"))
  Dir.glob(File.join("#{root}", @bower_config["directory"], "*", "fonts")) do |f|
    sprockets.append_path f
  end
  sprockets.append_path File.join "#{root}", @bower_config["directory"]
end

# Build-specific configuration
configure :build do
  activate :minify_css
  activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  activate :relative_assets
  set :relative_links, true
  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end

activate :deploy do |deploy|
  deploy.method = :sftp
  deploy.host     = 'integros.com'
  deploy.port     = 22
  deploy.path     = '/var/www/marketing_site/current/public'
  deploy.user     = 'deploy'
  deploy.build_before = true
#   deploy.host = "ftp-host"
#   deploy.user = "ftp-user"
#   deploy.password = "ftp-password"
#   deploy.path = "ftp-path"
end
