Redmine::Plugin.register :redmine_issue_evm do
  name 'Redmine Issue Evm plugin'
  author 'Hajime Nakagama'
  description 'This is a plugin for Redmine. Earned value management using the ticket of redmine.'
  version '0.1'
  url 'https://github.com/momibun926/redmine_issue_evm'
  author_url 'https://github.com/momibun926'
end

project_module :evm do
  permission :view_evm, :evm => [:index, :show]
end

menu :project_menu, :redmine_issue_evm, { :controller => 'evm', :action => 'index'}, :param => :project_id
