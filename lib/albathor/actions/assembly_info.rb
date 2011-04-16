module Albathor
  module AlbacoreTasks
    def assembly_info_task(opts={})
      append_to_file BUILD_FILE, <<-EOF, :verbose => false

assemblyinfo #{ inject_task_name opts, 'assemblyinfo' }#{ inject_dependency opts } do |asm|
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
