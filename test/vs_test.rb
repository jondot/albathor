require 'teststrap'

FIXTURE_PATH = File.expand_path(File.dirname(__FILE__)) + "/fixtures"
 

#Riot.pretty_dots
context "solution" do

  context "with main solution" do
    setup do
      Solution.new("#{FIXTURE_PATH}/actionpack/actionpack.sln")      
    end
    asserts("solution name"){ topic.name }.equals "ActionPack"
    asserts("projects count"){ topic.projects.count }.equals 2
    asserts("test projects"){ topic.test_projects.count }.equals 1

    denies("test project"){ topic.test_projects[0] }.nil
    asserts("test project output"){ topic.projects.find{|p| p.name =~/Test/}.output }.equals File.join FIXTURE_PATH, "actionpack/ActionView.Tests/bin/Release/ActionPack.Tests.dll"

  end



end
