class TypeStruct
  # IOLike = TypeStruct::Interface.new(
  #   :read,
  #   :write,
  #   :close,
  #   :closed?
  # )
  # IOLike === StringIO.new #=> true
  # IOLike === $stdin       #=> true
  # IOLike === 1            #=> false
  # IOLike === "io"         #=> false
  #
  # case $stdin
  # when IOLike
  #   puts "this is a io like object!"
  # end
  class Interface
    def initialize(*methods)
      @methods = methods
    end

    def |(other)
      Union.new(self, other)
    end

    def ===(other)
      @methods.all? do |m|
        other.respond_to?(m)
      end
    end
  end
end
