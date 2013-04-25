require_dependency 'weekly_report_hook_listener'

Redmine::Plugin.register :weekly_report do
  name 'Weekly Report plugin'
  author 'jetspeed'
  description 'This is a weekly report plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end
