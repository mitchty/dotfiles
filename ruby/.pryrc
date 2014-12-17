#-*-mode: Ruby; coding: utf-8;-*-

Pry.config.prompt = [
                     proc {|obj, nesting, _|
                       nesting == 0 ? "#{obj}> " : "#{obj}:#{nesting}> "
                     },
                     proc {''}
                    ]

def load_pry_debugstuff
  if Gem::Specification::find_all_by_name('pry-debugger').size > 0
    require 'pry-debugger'
    Pry.commands.alias_command 'c', 'continue'
    Pry.commands.alias_command 's', 'step'
    Pry.commands.alias_command 'n', 'next'
  end
end

load_pry_debugstuff
