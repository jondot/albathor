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


private
    def inject_dependency(params)
      ' => ' + params[:depends].inspect.to_s if params[:depends] 
    end
  end
end 
