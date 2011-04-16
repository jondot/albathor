module Albathor
  module AlbacoreTasks
    def xunit_task(exe_folder, opts={})
      append_to_file BUILD_FILE, <<-EOF, :verbose => false
desc "Run tests with XUnit"
xunit :xunit#{ inject_dependency opts } do |nunit|
  nunit.command = "#{exe_folder}/xunit.console.exe"
  nunit.assembly "#{ vars[:solution].has_test_projects? ? vars[:solution].test_projects[0].output : 'TEST_ASSEMBLY'}"
end
      EOF

    end
  end
end
