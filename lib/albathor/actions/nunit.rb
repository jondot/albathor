module Albathor
  module AlbacoreTasks
    def nunit_task(exe_folder, opts={})
      append_to_file BUILD_FILE, <<-EOF, :verbose => false
desc "Run tests"
nunit :nunit#{ inject_dependency opts } do |nunit|
  nunit.command = "#{exe_folder}/nunit-console.exe"
  nunit.assemblies "#{ vars[:solution].has_test_projects? ? vars[:solution].test_projects[0].output : 'TEST_ASSEMBLY'}"
end
      EOF
    end
  end
end
