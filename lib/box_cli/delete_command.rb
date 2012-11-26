module BoxCli
  class DeleteCommand < BoxCommand
    def call
      item_name, = @args
      wrapper.delete(item_name)
    end
  end
end