module Albathor
  module AlbacoreTasks
    def nuget_task(exe_folder, input_folder, opts)
      append_to_file BUILD_FILE, <<-EOF, :verbose => false

desc "create a nuget package"
nugetpack :nuget#{inject_dependencies} do |nuget|
   nuget.command     = "#{exe_folder}/nuget.exe"
   nuget.nuspec      = "#{vars[:solution].name}.nuspec"
   nuget.base_folder = "#{input_folder}"
   nuget.output      = "pkg"
end
      EOF
    end
  end
end
