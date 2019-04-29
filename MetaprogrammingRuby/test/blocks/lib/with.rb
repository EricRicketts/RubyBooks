module Kernel
  def with(resource)
    begin
      yield
    ensure
      resource.dispose
    end
  end
end
=begin
this is a good solution because in adding #with
to the Kernel module it is available for every
object.
=end
