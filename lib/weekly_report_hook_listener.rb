# encoding: utf-8
class WeeklyReportHookListener < Redmine::Hook::ViewListener
	def view_projects_show_right(context = {})
		html = '<div class="box" id="statuses">'
		html += '<h3 class="icon22 icon22-users">Weekly Report</h3><ul>'
		issues = weekly_report(context[:project])

		issues.each_key do |k|
			html += '<h4>' + k.to_s + ':' + issues[k].count.to_s + '</h4>'
			issues[k].each do |issue|
				html += <<EOHTML
				<li>
	        #{link_to h(truncate(issue.subject, :length => 60)), :controller => 'issues', :action => 'show', :id => issue}
	      </li>
EOHTML
			end
		end
    html += '</ul></div>'
    return html
  end

  def weekly_report(project)
  	issues = {}
  	status_hash = {:new => [1], :dev => [8, 13, 17], :test => [9, 14, 15], :uat => [10, 16], :production => [11], :closed => [5]}

  	status_hash.each_key do |k|
  		issues[k] =  project.issues.select {|i| status_hash[k].include? i.status_id and  bug_source_nil_or_production(i.custom_value_for(6))} 
  	end

  	issues[:closed] = issues[:closed].select {|i| i.updated_on > Time.now.beginning_of_week}
  	issues
  end

  def bug_source_nil_or_production(str)
  	str.nil? or str.value.empty? or str.value.eql?("生产")
  end
end
