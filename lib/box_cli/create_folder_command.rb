module BoxCli
  class CreateFolderCommand < BoxCommand
    def call
      folder_name, = @args
      folder_id = wrapper.create_folder(folder_name)
      puts "Created folder '#{folder_name}' (id: #{folder_id})"
    end
  end
end