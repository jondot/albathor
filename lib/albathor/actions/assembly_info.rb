module Albathor
  module AlbacoreTask
    def assembly_info_task(exe_folder, opts={})
      append_to_file BUILD_FILE, <<-EOF, :verbose => false
assemblyinfo :assemblyinfo#{inject_dependencies} do |asm|
  asm.version = BUILD_VERSION
  asm.file_version = BUILD_VERSION
  asm.company_name = "#{vars[:env].organization}"
  asm.product_name = "#{vars[:solution].name}"
  asm.copyright = "Copyright (c) #{vars[:env].organization}"
  asm.output_file = "AssemblyInfo.cs"
end
      EOF
    end
  end
end
