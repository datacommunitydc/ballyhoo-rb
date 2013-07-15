module ApplicationHelper
  def login_path
    if Rails.env == 'development'
      '/auth/developer'
    else
      '/auth/meetup'
    end
  end

  def render_javascript_templates
    out = []
    path_base = "#{Rails.root}/app/views/js_templates/"
    Dir.glob("#{path_base}/**/*.html.*").each do |template_path|
      local_path   = template_path.sub(path_base, '')
      partial_path = local_path.sub(/\/_/, '/')
      name_path    = partial_path.sub(/\..*$/, '').sub(/^\//,'')

      out << %Q{<script type="text/ng-template" id="#{name_path}">}
      out << render("js_templates/#{partial_path}")
      out << %Q{</script>}
    end
    out.join.html_safe
  end
end
