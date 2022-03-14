#!/usr/bin/ruby -w

class Html
  attr_accessor :page_name

  def initialize(name)
    @page_name = name

    head()
  end
  
  def head
    begin
      @file_path = File.dirname(__FILE__) + "/#{@page_name}.html"

      if File.exist?(@file_path)
        raise "A file named #{@page_name}.html already exist!"
      end
      @file = File.open(@file_path, "w")

      @file.write("<!DOCTYPE html>\n" +
        "<html>\n" +
          "\t<head>\n" +
            "\t\t<title>#{@page_name}</title>\n" +
          "\t</head>\n" +
        "<body>\n")
        @file.close

    rescue Exception => e
      puts e.message
    end
  end

  def dump(text)
    begin
      @file = File.open(@file_path, "a+")
      f = @file.read

      unless f.include?("<body>")
        raise "There is no body tag in #{@page_name}.html"
      end
      if f.include?("</body>")
        raise "Body has already been closed in #{@page_name}.html"
      end

      @file.write("\t<p>#{text}</p>\n")
    rescue Exception => e
      puts e.message
    ensure
      @file.close
    end
  end

  def finish
    begin
      @file = File.open(@file_path, "a+")

      if @file.read.include?("</body>")
        raise "#{page_name}.html has already been closed."
      end
      @file.write("</body>")
    rescue Exception => e
      puts e.message
    ensure
      @file.close
    end
  end

end

if __FILE__ == $0
  html = Html.new("test")
  
  puts html.page_name
  10.times{|x| html.dump("titi_number#{x}")}
  html.finish
  html.finish
  html.dump("titi_number")
  html.head
end