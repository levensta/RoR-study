#!/usr/bin/ruby -w

class Html
  attr_accessor :page_name

  def initialize(name)
    @page_name = name

    head()
  end
  
  def head
    @file_path = File.dirname(__FILE__) + "/#{@page_name}.html"
    @file = File.open(@file_path, "w")

    @file.write("<!DOCTYPE html>\n" +
      "<html>\n" +
        "\t<head>\n" +
          "\t\t<title>#{@page_name}</title>\n" +
        "\t</head>\n" +
      "<body>\n")
      @file.close
  end

  def dump(text)
    @file = File.open(@file_path, "a")
    @file.write("\t<p>#{text}</p>\n")
    @file.close
  end

  def finish
    @file = File.open(@file_path, "a")
    @file.write("</body>")
    @file.close
  end

end

if __FILE__ == $0
  html = Html.new("test")
  
  puts html.page_name
  10.times{|x| html.dump("titi_number#{x}")}

  html.finish
end