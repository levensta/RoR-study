#!/usr/bin/ruby -w

def getContentTable
  max_pos = 17
  file_path = File.dirname(__FILE__) + "/periodic_table.txt"
  unless File.exist?(file_path)
    abort "File not found"
  end

  file = File.new(file_path, "r:UTF-8")
  contentTable = "\t" * 2 + "<tr>\n"
  pos = 0

  file.readlines().each_with_index do |elem, index|
    elem = elem.split(/ = |position:|, |\n/).reject(&:empty?)
    elemPos = elem[1].to_i
    diffPos = elemPos - pos
    
    if elemPos != pos
      contentTable += ("\t" * 3 + "<td></td>\n") * diffPos
      pos += diffPos
    end
    contentTable += "\t" * 3 + "<td>\n" +
    "\t" * 4 + "<h4>#{elem[0]}</h4>\n" +
    "\t" * 4 + "<ul>\n" +
    "\t" * 5 + "<li>#{elem[2]}</li>\n" +
    "\t" * 5 + "<li>#{elem[3]}</li>\n" +
    "\t" * 5 + "<li>#{elem[4]}</li>\n" +
    "\t" * 5 + "<li>#{elem[5]}</li>\n" +
    "\t" * 4 + "</ul>\n" + "\t" * 3 + "</td>\n"
    if pos == max_pos
      contentTable += "\t" * 2 + "</tr>\n"
      pos = 0
    else
      pos += 1
    end
  end
  file.close()
  return contentTable
end

def createPage
  page = "<!DOCTYPE html>\n" +
  "<html lang=\"en\">\n" +
  "<head>\n" +
      "\t<meta charset=\"UTF-8\">\n" +
      "\t<title>Periodic Table</title>\n" +
      "\t<style>td {border: 1px solid black;}</style>" +
  "</head>\n" +
  "<body>\n" +
      "\t<table>\n" +
        getContentTable() +
      "\t</table>\n" +
  "</body\n>" + "</html>"

  periodic_table_html = File.new(File.dirname(__FILE__) + "/periodic_table.html", "w:UTF-8")
  periodic_table_html.print(page)
  periodic_table_html.close()
end

if __FILE__ == $0
  createPage
end