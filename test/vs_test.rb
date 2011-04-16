require 'teststrap'

FIXTURE_PATH = File.expand_path(File.dirname(__FILE__)) + "/fixtures"
 

#Riot.pretty_dots
context "given a solution" do

  context "and an existing test project" do
    setup do
      Albathor::VS::Solution.new("#{FIXTURE_PATH}/actionpack/actionpack.sln")      
    end
    asserts(:name).equals "ActionPack"
    asserts(:projects).size 2
    asserts(:test_projects).size 1
    asserts("test project output"){ topic.projects.find{|p| p.name =~/Test/}.output }.equals "ActionView.Tests/bin/Release/ActionPack.Tests.dll"
  end


  context "and different project types" do
    setup do
      Albathor::VS::Solution.new("#{FIXTURE_PATH}/project_types/project_types.sln")      
    end

    asserts("web project count"){ topic.projects.count{|p| p.web? } }.equals 2
    asserts("test project count"){ topic.projects.count{|p| p.test? } }.equals 0
    asserts("mvc2 project count"){ topic.projects.count{|p| p.project_types.include? :web_mvc2 } }.equals 1
    asserts("aspnet project count"){ topic.projects.count{|p| p.project_types.include? :web_aspnet } }.equals 2
  end

  context "and test project types" do
    setup do
      Albathor::VS::Solution.new("#{FIXTURE_PATH}/test_project_types/test_project_type.sln")      
    end

    asserts("test project count"){ topic.projects.count{|p| p.test? } }.equals 2
    denies("test_project_type is a test project"){ topic.projects.any? {|p| p.test? && p.name == "test_project_type"}}
  end

end
