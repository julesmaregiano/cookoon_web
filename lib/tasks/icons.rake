require 'rake'
require 'byebug'

namespace :icons do

  desc "update the icon font files from a newly downloaded zip file"
  task :update, [:zipfile] => [:environment] do |t, args|
    begin
      # Set absolute zipfile path in ~/Downloads
      zipfile = File.join(ENV['HOME'], 'Downloads', args[:zipfile].shellescape)

      # Set some dir vars
      tmpdir = File.join(Rails.root, 'tmp', 'iconfont')
      vendorfontsdir = File.join(Rails.root, 'app', 'assets', 'fonts')
      vendorcssdir = File.join(Rails.root, 'app', 'assets', 'stylesheets', 'vendor')

      # Create the tmp folder for extracted zip
      unless File.directory? tmpdir
        system "mkdir #{tmpdir}"
      end

      # Unzip that motherfucker
      system "unzip -u #{zipfile} -d #{tmpdir}"

      # Copy the font files
      Dir.glob(File.join(tmpdir, 'fonts', '*')) do |file|
        puts "Copying #{file} to #{vendorfontsdir}"
        system "cp #{file} #{vendorfontsdir}"
      end

      # Copy the stylesheet
      puts 'Copying the stylesheet'
      stylesheet = File.join(vendorcssdir, '_icons.scss')
      system "cp #{File.join(tmpdir, 'style.css')} #{stylesheet}"

      # Replace the font urls in the stylesheet
      puts 'Updating font URLs in stylesheet'
      stylesheet_content = File.read(stylesheet)
      stylesheet_content.gsub!("url('fonts/", "font-url('")
      stylesheet_content.sub!(/[i]\s[{]/, ".co {")
      File.open(stylesheet, 'w') do |file|
        file.write(stylesheet_content)
      end

    ensure
      puts 'Deleting tmp folder'
      if File.directory? tmpdir
        system "rm -rf #{tmpdir}"
      end

    end
  end

end