module BoxCli
  class UploadCommand < BoxCommand
    def call
      path, folder_path = @args
      wrapper.upload(path, folder_path)
    end
  end
end