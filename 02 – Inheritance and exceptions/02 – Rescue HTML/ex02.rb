#!/usr/bin/ruby -w

class Dup_file < StandardError
  def initialize(file_path)
    @file_path = file_path
    @absolute_path = File.expand_path(file_path)
  end

  def show_state
    puts "A file named #{File.basename(@absolute_path)} was already there: " + @absolute_path
  end

  def correct(newExtension = "")
    @new_absolute_filename = File.dirname(@absolute_path) + "/#{File.basename(@absolute_path, ".html")}" + newExtension + ".html"
    
    if File.exist?(@new_absolute_filename)
      correct(newExtension += ".new")
    else
      f = File.new(File.dirname(@file_path) + "/#{File.basename(@new_absolute_filename)}", "w:UTF-8")
      f.write("<!DOCTYPE html>\n" +
        "<html>\n" +
          "\t<head>\n" +
            "\t\t<title>#{File.basename(@new_absolute_filename, ".html")}</title>\n" +
          "\t</head>\n" +
        "<body>\n")
      f.close
      return File.basename(@new_absolute_filename, ".html")
    end
  end

  def explain
    puts "Appended .new in order to create requested file: #{@new_absolute_filename}"
  end
end

class Body_closed < StandardError
  def initialize(file, file_path, content, text)
    @file = file
    @file_path = file_path
    @content = content
    @text = text
  end

  def show_state
    puts "In #{File.basename(@file_path)} body was closed :"
  end

  def correct
    @file.close
    @file = File.open(@file_path, "w")
  
    @content.sub!("</body>", "")
    @file.write(@content + "\t<p>#{@text}</p>\n</body>")
    @file.close
  end

  def explain
    puts "  > ln :#{@content.split("\n").length + 1} </body> : text has been inserted and tag moved at the end of it"
  end
end

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
        raise Dup_file.new(@file_path)
      end
      @file = File.open(@file_path, "w")

      @file.write("<!DOCTYPE html>\n" +
        "<html>\n" +
          "\t<head>\n" +
            "\t\t<title>#{@page_name}</title>\n" +
          "\t</head>\n" +
        "<body>\n")
        @file.close

    rescue Dup_file => e
      e.show_state
      @page_name = e.correct
      @file_path = File.dirname(__FILE__) + "/#{@page_name}.html"
      e.explain
    end
  end

  def dump(text)
    begin
      @file = File.open(@file_path, "a+")
      content = @file.read

      unless content.include?("<body>")
        raise "There is no body tag in #{@page_name}.html"
      end
      if content.include?("</body>")
        raise Body_closed.new(@file, @file_path, content, text)
      end

      @file.write("\t<p>#{text}</p>\n")
      @file.close
    rescue Body_closed => e
      e.show_state
      e.correct
      e.explain
    rescue Exception => e
      puts e.message
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
  
  # puts html.page_name
  10.times{|x| html.dump("titi_number#{x}")}
  # html.finish
  html.finish
  html.dump("titi_number")
  # html.head
end