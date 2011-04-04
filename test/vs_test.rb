require 'teststrap'

FIXTURE_PATH = File.expand_path(File.dirname(__FILE__)) + "/fixtures"
 

#Riot.pretty_dots
context "solution" do

  context "with main solution" do
    setup do
      Albathor::VS::Solution.new("#{FIXTURE_PATH}/actionpack/actionpack.sln")      
    end
    asserts("solution name"){ topic.name }.equals "ActionPack"
    asserts("projects count"){ topic.projects.count }.equals 2
    asserts("test projects"){ topic.test_projects.count }.equals 1

    denies("test project"){ topic.test_projects[0] }.nil
    asserts("test project output"){ topic.projects.find{|p| p.name =~/Test/}.output }.equals "ActionView.Tests/bin/Release/ActionPack.Tests.dll"
  end


  context "project types" do
    setup do
      Albathor::VS::Solution.new("#{FIXTURE_PATH}/project_types/project_types.sln")      
    end

    asserts("web project count"){ topic.projects.count{|p| p.web? } }.equals 2
    asserts("test project count"){ topic.projects.count{|p| p.test? } }.equals 0
    asserts("mvc2 project count"){ topic.projects.count{|p| p.project_types.include? :web_mvc2 } }.equals 1
    asserts("aspnet project count"){ topic.projects.count{|p| p.project_types.include? :web_aspnet } }.equals 2
  end
end
