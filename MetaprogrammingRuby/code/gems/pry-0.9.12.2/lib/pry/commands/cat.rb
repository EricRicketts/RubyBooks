#---
# Excerpted from "Metaprogramming Ruby 2",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material,
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose.
# Visit http://www.pragmaticprogrammer.com/titles/ppmetr2 for more book information.
#---
class Pry
  class Command::Cat < Pry::ClassCommand
    require 'pry/commands/cat/abstract_formatter.rb'
    require 'pry/commands/cat/input_expression_formatter.rb'
    require 'pry/commands/cat/exception_formatter.rb'
    require 'pry/commands/cat/file_formatter.rb'

    match 'cat'
    group 'Input and Output'
    description "Show code from a file, Pry's input buffer, or the last exception."

    banner <<-'BANNER'
      Usage: cat FILE
             cat --ex [STACK_INDEX]
             cat --in [INPUT_INDEX_OR_RANGE]

      `cat` is capable of showing part or all of a source file, the context of the
      last exception, or an expression from Pry's input history.

      `cat --ex` defaults to showing the lines surrounding the location of the last
      exception. Invoking it more than once travels up the exception's backtrace, and
      providing a number shows the context of the given index of the backtrace.
    BANNER

    def options(opt)
      opt.on :ex,        "Show the context of the last exception", :optional_argument => true, :as => Integer
      opt.on :i, :in,    "Show one or more entries from Pry's expression history", :optional_argument => true, :as => Range, :default => -5..-1
      opt.on :s, :start, "Starting line (defaults to the first line)", :optional_argument => true, :as => Integer
      opt.on :e, :end,   "Ending line (defaults to the last line)", :optional_argument => true, :as => Integer
      opt.on :l, :'line-numbers', "Show line numbers"
      opt.on :t, :type,  "The file type for syntax highlighting (e.g., 'ruby' or 'python')", :argument => true, :as => Symbol
    end

    def process
      output = case
               when opts.present?(:ex)
                 ExceptionFormatter.new(_pry_.last_exception, _pry_, opts).format
               when opts.present?(:in)
                 InputExpressionFormatter.new(_pry_.input_array, opts).format
               else
                 FileFormatter.new(args.first, _pry_, opts).format
               end

      stagger_output(output)
    end

    def complete(search)
      super + Bond::Rc.files(search.split(" ").last || '')
    end
  end

  Pry::Commands.add_command(Pry::Command::Cat)
end
