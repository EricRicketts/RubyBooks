#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::GemCd < Pry::ClassCommand
    match 'gem-cd'
    group 'Gems'
    description "Change working directory to specified gem's directory."
    command_options :argument_required => true

    banner <<-'BANNER'
      Usage: gem-cd GEM_NAME

      Change the current working directory to that in which the given gem is
      installed.
    BANNER

    def process(gem)
      Dir.chdir(Rubygem.spec(gem).full_gem_path)
      output.puts(Dir.pwd)
    end

    def complete(str)
      Rubygem.complete(str)
    end
  end

  Pry::Commands.add_command(Pry::Command::GemCd)
end
