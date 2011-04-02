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

  end
end
