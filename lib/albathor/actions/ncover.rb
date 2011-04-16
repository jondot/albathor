module Albathor
  module AlbacoreTasks
    def ncover_task(ncover_exe_folder=nil, nunit_exe_folder=nil, opts={})
      ncover_exe_folder = tuck_and_get :ncover_exe_folder, ncover_exe_folder
      nunit_exe_folder  = tuck_and_get :nunit_exe_folder, nunit_exe_folder


      append_to_file BUILD_FILE, <<-EOF, :verbose => false

desc "NCover Console code coverage"
ncoverconsole #{ inject_task_name opts, 'ncover' }#{ inject_dependency opts } |ncc|
  ncc.command = "#{ncover_exe_folder || 'tools/ncover'}/NCover.Console.exe"
  ncc.output :xml => "test-coverage.xml"
  ncc.cover_assemblies '#{ vars[:solution].find_project(:output=>'OUTPUT'){|p| !p.test? }.output }'

  nunit = NUnitTestRunner.new("#{nunit_exe_folder || 'tools/nunit' }/nunit-console.exe")
  #  nunit.options '/framework=4.0.30319', '/noshadow'
  nunit.options '/noshadow'
  nunit.assemblies '#{ vars[:solution].find_project(:output=>'TEST_ASSEMBLY'){|p| p.test? }.output }'
  ncc.testrunner = nunit
end
      EOF

    end
  end
end
