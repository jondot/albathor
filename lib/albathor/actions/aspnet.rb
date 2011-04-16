module Albathor
  module AlbacoreTasks
    def aspnet_task(web_output_folder=nil, opts={})
      web_output_folder = tuck_and_get :web_output_folder, web_output_folder

      if vars[:solution].has_web_projects? 
        vars[:solution].web_projects.each do |p|
          # todo: snake case p.name in const.
          
          append_to_file BUILD_FILE, <<-EOF, :verbose => false

desc "asp compile"
aspnetcompiler #{ inject_task_name opts, 'precompile' }_#{p.name}#{ inject_dependency opts } do |c|
  c.physical_path = "#{p.directory}"
  c.target_path = "#{web_output_folder || 'web_out' }/#{p.name}"
  c.updateable = true
  c.force = true
end
          EOF
        end #each
      end #if
    end
  end
end

