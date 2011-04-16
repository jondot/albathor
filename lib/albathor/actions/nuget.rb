module Albathor
  module AlbacoreTasks
    def nuget_task(nuget_exe_folder = nil, nuget_input_folder = nil, opts={})
      nuget_exe_folder   = tuck_and_get :nuget_exe_folder, nuget_exe_folder
      nuget_input_folder = tuck_and_get :nuget_input_folder, nuget_input_folder

      append_to_file BUILD_FILE, <<-EOF, :verbose => false

desc "create a nuget package"
nugetpack #{ inject_task_name opts, 'nuget' }#{ inject_dependency opts } do |nuget|
   nuget.command     = "#{nuget_exe_folder || 'tools/nuget'}/nuget.exe"
   nuget.nuspec      = "#{vars[:solution].name}.nuspec"
   nuget.base_folder = "#{nuget_input_folder || 'out'}"
   nuget.output      = "pkg"
end
      EOF
    end
  end
end
