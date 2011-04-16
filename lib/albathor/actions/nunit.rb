module Albathor
  module AlbacoreTasks
    def nunit_task(nunit_exe_folder=nil, opts={})
      nunit_exe_folder = tuck_and_get :nunit_exe_folder, nunit_exe_folder

      append_to_file BUILD_FILE, <<-EOF, :verbose => false

desc "Run tests"
nunit #{ inject_task_name opts, 'nunit' }#{ inject_dependency opts } do |nunit|
  nunit.command = "#{ nunit_exe_folder || 'tools/nunit' }/nunit-console.exe"
  nunit.assemblies "#{ vars[:solution].find_project(:output=>'TEST_ASSEMBLY'){|p| p.test?}.output }"
end
      EOF
    end
  end
end
