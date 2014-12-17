#!/usr/bin/env ruby
#

cal, today, week_color, day_color, reset = %x(cal).split(%r(\n)), Time.now.day, %x(tput sgr0;tput setab 4;tput setaf 7), %x(tput sgr0; tput setab 0;tput setaf 7;tput bold), %x(tput sgr0)
done=false
cal.each do |line|
  if done then
    puts line
    next
  end
  if(line =~ /^(.*\s+?)#{today}(\s+?.*)$/ or
     line =~ /^(.*\s+?)#{today}$/ or
     line =~ /^()#{today}(\s+?.*)$/ or
     line =~ /^#{today}$/ ) then
    puts "#{week_color}#{$1}#{day_color}#{today}#{week_color}#{$2}#{reset}"
    done=true
  else
    puts line
  end
end
