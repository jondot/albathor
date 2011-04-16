require 'nokogiri'
require 'pathname'

module Albathor
  module VS
    class Project
      attr_reader :name
      attr_reader :file
      attr_reader :output
      attr_reader :project_types

      def initialize(prfile, opts = {})
        @file = File.expand_path("#{prfile}")
        @name = File.basename(@file, ".csproj")

        @solution_path = opts[:solution_path] || '.'
        @project_types = []

        throw "Project #{@file} must exist." unless File.exists? @file
      
        parse(File.read(@file))
      end

      def directory
        File.dirname(file)
      end

      def test?
        project_types.any? {|t| ProjectTypes.test? t } 
      end

      def web?
        project_types.any? {|t| ProjectTypes.web? t } 
      end

    private
      def parse(contents)
        doc = ::Nokogiri::XML(contents)
        
        populate_project_types doc
        populate_output doc
      end

      def populate_project_types(doc)
        guids = doc.css('ProjectTypeGuids').text.split ';'
        @project_types = guids.map {|g| ProjectTypes.to_type g }.compact
      end

      def populate_output(doc)
        @output = File.join File.dirname(file), 
            (doc.css('PropertyGroup[Condition*=Release] > OutputPath').text || doc.css('PropertyGroup[Condition*=Debug] > OutputPath').text).gsub("\\","/"),
            doc.css('PropertyGroup > AssemblyName').text
        @output += ".dll"
        @output = solution_relative_path @output
      end 

      def solution_relative_path(path)
        Pathname.new(path).relative_path_from(Pathname.new(@solution_path)).to_s
      end
    end



    class Solution
      attr_reader :file
      attr_reader :name
      attr_reader :path
      attr_reader :projects

      def initialize(slfile)
        @file = File.expand_path("#{slfile}")
        throw "Solution #{@file} must exist." unless File.exist?(@file)

        @name = File.basename(@file, ".sln")
        @path = File.dirname(@file)
        @projects = []

        populate_projects File.read(@file)
      end

      def has_test_projects?
        test_projects.count > 0
      end

      def test_projects
        projects.select { |p| p.test? || p.name =~ /(Test|Tests)$/ }
      end

      def has_web_projects?
        web_projects.count > 0
      end

      def web_projects
        projects.select {|p| p.web? }
      end
    private 

      def populate_projects(contents)
        contents.lines.each do |line|
          @projects << Project.new(File.join(@path, $1), :solution_path => path) if(line =~ /Project.*=.*?,\s*"(.*)"\s*,.*?/ && File.exist?(File.join(@path, $1)))
        end
      end
    end
    
  end
end


