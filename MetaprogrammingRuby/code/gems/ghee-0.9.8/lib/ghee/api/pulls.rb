#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Ghee

  # API module encapsulates all of API endpoints
  # implemented thus far
  #
  module API

    # The Repos module handles all of the Github Repo
    # API endpoints
    #
    module Repos

      module Pulls
        class Proxy < ::Ghee::ResourceProxy
          include Ghee::CUD

          def commits
            connection.get("#{path_prefix}/commits").body
          end
          
          def files
            connection.get("#{path_prefix}/files").body
          end
          
          def merge?
            connection.get("#{path_prefix}/merge").status == 204
          end
          
          def merge!(message=nil)
            params = message ? {:commit_message=>message} : {}
            connection.put("#{path_prefix}/merge", params).body
          end
        end
      end

      # Gists::Proxy inherits from Ghee::Proxy and
      # enables defining methods on the proxy object
      #
      class Proxy < ::Ghee::ResourceProxy
        def pulls(number=nil, params={})
          params = number if number.is_a?Hash
          prefix = (!number.is_a?(Hash) and number) ? "#{path_prefix}/pulls/#{number}" : "#{path_prefix}/pulls"
          Ghee::API::Repos::Pulls::Proxy.new(connection, prefix, params)
        end
      end
    end
  end
end

