require 'thor/group'
require 'albathor/vs/solution'
require 'albathor/actions/albacore_tasks'

module Albathor
  class CLI < Thor
    include Thor::Actions
    include Albathor::AlbacoreTasks

    source_paths << File.expand_path("../../../templates",__FILE__)
    source_paths << Dir.pwd


    method_option :version_bumper, :type => :boolean, :aliases => "-b" 
    desc "init SOLUTION_NAME [TEMPLATE_LOCATION]", "Initialize an Albacore build"
    def init(solution_name, template_location="default.alba")
      puts "Creating Albacore build for #{solution_name}.sln"
      vars[:solution] = Solution.new "#{solution_name}.sln"

      template 'Rakefile'
      template 'Gemfile'
      
      apply template_location

      say "Done. Run 'bundle install' once to set up your dependencies."
    end

  protected
    def vars
      @vars ||= {}
    end
  end

end



