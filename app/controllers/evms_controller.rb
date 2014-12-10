
include EvmLogic, ProjectAndVersionValue


class EvmsController < ApplicationController
  unloadable

  menu_item :issueevm

  model_object Evmbaseline

  # filter
  before_filter :find_project, :authorize

  def index
  	@basis_date = Time.now.utc.to_date
  	@baseline_id = params[:evmbaseline_id].nil? ? nil : params[:evmbaseline_id]
  	@evmbaseline = Evmbaseline.where('project_id = ? ', @project.id).order('created_on DESC')
    # parameters
    @actual_basis = params[:actual_basis]
    @forecast = params[:forecast]
    @calcetc = params[:calcetc].nil? ? 'method2' : params[:calcetc]
    @display_explanation = params[:display_explanation]
    @display_version = params[:display_version]

    #Project. all versions
    baselines = project_baseline @project, @baseline_id
    issues = project_issues @project
    actual_cost = project_costs @project
    @project_evm = IssueEvm.new(baselines, issues, actual_cost, @basis_date, params[:forecast], params[:calcetc], params[:actual_basis])

    #versions
    @version_evm = {}
    unless @project.versions.nil?
      @project.versions.each do |version|
        issues = version_issues @project, version.id
        actual_cost = version_costs @project, version.id
        @version_evm[version.id] = IssueEvm.new(nil, issues, actual_cost, @basis_date, nil, nil, true)
      end
    end 

    #future
    @display_performance_is_enabled = params[:display_performance]

  end

private
  def find_project
    @project = Project.find(params[:project_id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

end
