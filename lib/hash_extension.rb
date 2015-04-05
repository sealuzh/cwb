# Implementation based on blogpost: http://reedy.in/words/archive/2015/01/08/deep-fetch/
# and hashie: https://github.com/intridea/hashie/blob/master/lib/hashie/extensions/deep_fetch.rb
module HashExtension
  def deep_fetch(*keys, default: nil, &block)
    keys.reduce(self) do |obj, arg|
      begin
        arg = Integer(arg) if obj.is_a? Array
        obj.fetch(arg)
      rescue => e
        break block.call(arg) if block
        if default.nil?
          raise KeyError, "Could not fetch keypath (#{keys.join('.')}) at #{arg}", e.backtrace
        else
          default
        end
      end
    end
  end

  def fetch_keypath(keypath, default: nil)
    deep_fetch(*keypath.split('.'), default: default)
  end
end
