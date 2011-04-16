module Albathor
  module AlbacoreTasks
    def xunit_task(xunit_exe_folder=nil, opts={})
      xunit_exe_folder = tuck_and_get :xunit_exe_folder, xunit_exe_folder

      append_to_file BUILD_FILE, <<-EOF, :verbose => false

desc "Run tests with XUnit"
xunit #{ inject_task_name opts, 'xunit' }#{ inject_dependency opts } do |xunit|
  xunit.command = "#{xunit_exe_folder || 'tools/xunit'}/xunit.console.exe"
  xunit.assembly "#{ vars[:solution].find_project(:output=>'TEST_ASSEMBLY'){|p| p.test?}.output }"
end
      EOF

    end
  end
end
