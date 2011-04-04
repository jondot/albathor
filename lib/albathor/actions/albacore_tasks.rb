require 'zip/zip'
require 'fileutils'

module Albathor
  module AlbacoreTasks
    include FileUtils

    BUILD_FILE = 'Rakefile'

    def unzip(zipfile, opts)
      opts = {:to =>'.'}.merge(opts)
      Zip::ZipFile.open(zipfile) do |z|
        z.each do |f|
           to_file = File.join(opts[:to], f.name)
           mkdir_p(File.dirname(to_file))
           z.extract(f, to_file) unless File.exist?(to_file)
        end
      end
      rm zipfile if opts[:remove]
    end

    def nunit(exe_folder)
      append_to_file BUILD_FILE, <<-EOF, :verbose => false
desc "Run tests"
nunit :nunit do |nunit|
  nunit.command = "#{exe_folder}/nunit-console.exe"
  nunit.assemblies "#{ vars[:solution].has_test_projects? ? vars[:solution].test_projects[0].output : 'TEST_ASSEMBLY'}"
end
      EOF
    end

    def aspnet(output)
      web_proj_dir = vars[:solution].has_web_projects? ? vars[:solution].web_projects[0].directory : 'FILL_ME'

      if vars[:solution].has_web_projects? 
        vars[:solution].web_projects.each do |p|
          # todo: snake case p.name in const.
          
          append_to_file BUILD_FILE, <<-EOF, :verbose => false

desc "asp compile"
aspnetcompiler :precompile_#{p.name} do |c|
  c.physical_path = "#{p.directory}"
  c.target_path = "#{output}/#{p.name}"
  c.updateable = true
  c.force = true
end
          EOF
        end
      end
     
     
    end
  end
end
