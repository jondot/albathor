module Albathor
  module AlbacoreTask
    def aspnet_task(output_folder, opts={})
      web_proj_dir = vars[:solution].has_web_projects? ? vars[:solution].web_projects[0].directory : 'FILL_ME'

      if vars[:solution].has_web_projects? 
        vars[:solution].web_projects.each do |p|
          # todo: snake case p.name in const.
          
          append_to_file BUILD_FILE, <<-EOF, :verbose => false

desc "asp compile"
aspnetcompiler :precompile_#{p.name}#{ inject_dependency opts } do |c|
  c.physical_path = "#{p.directory}"
  c.target_path = "#{output_folder}/#{p.name}"
  c.updateable = true
  c.force = true
end
          EOF
        end #each
      end #if
    end
  end
end

