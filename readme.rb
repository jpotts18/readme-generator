#! /bin/ruby

puts `cat txt/manifest.txt`

system_deps = Dir.glob('system-dependencies/*.md')
starts = Dir.glob('getting-started/*.md')

print 'What is the name of your app: '

app_name = gets.chomp

File.open('temp.md','w') do |f|

	# Introduction
	
	if app_name.empty?
		abort 'You must provide a name to generate a README silly! :('
	else
		f.puts "# #{app_name}"
		f.puts ""
		f.puts "Here is a brief project description"
		f.puts ""
	end

	# Getting Started

	print 'Would you like to include Getting Started? [Y/n]: '
	get_started = gets.chomp

	if get_started.include?('n') || get_started.include?('N')
		puts 'I guess I\'ll never know how to use it :('
	else
		puts '' 
		starts.each_with_index do |item, index|
			puts "[#{index}] #{item.split('/')[1]}"
		end
		puts ''

		print "Which would you like to include: "
		start_index = gets.chomp.to_i

		if start_index >= 0 && start_index < starts.count
			text = File.open(starts[start_index],'r').read
			f.puts ''
			f.puts text
			f.puts ''
		end
	end

  # System Dependencies

  print 'Would you like to include System Dependencies? [Y/n]: '
  sys_deps = gets.chomp

  if sys_deps.include?('n') || sys_deps.include?('N')
    puts 'I\'ll have to ask you a million questions but I guess you don\'t mind :('
  else
    puts '' 
    system_deps.each_with_index do |item, index|
      puts "[#{index}] #{item.split('/')[1]}"
    end
    puts ''

    print "Which would you like to include: "
    selection = gets.chomp.to_i

    if selection >= 0 && selection < system_deps.count
      text = File.open(system_deps[selection],'r').read
      f.puts ''
      f.puts text
      f.puts ''
    end
  end

	# System Overview

	print 'Would you like to include a System Overview? [Y/n]: '
	sys_overview = gets.chomp

	if sys_overview.include?('n') || sys_overview.include?('N')
		puts 'No one will know the big picture but okay I guess... :('
	else 
		sys_overview_file = File.open('system-overview.md','r').read
		f.puts ''
		f.puts sys_overview_file
		f.puts ''
	end

  # Contributions
  
	print 'Would you like to include a Contributing Section? [Y/n]: '

	contributions = gets.chomp

	if contributions.include?('n') || contributions.include?('N')
		puts 'I recommend coding with friends and sharing, but it\'s up to you :('
	else
    text = File.open('contributing.md', 'r').read
    f.puts ''
    f.puts text
    f.puts ''
	end
end

system 'open', 'temp.md'
