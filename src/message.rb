module Message

  def box(text, size)
    k = text.length + 2
    l = "│#{text}#{" "*(size - k)}│"
    return l
  end

  def align(text, size)
=begin
    lines = Array.new
    paragraph = String.new
    words = text.to_s.split("\n")
    words.length.times do |i|
      lines.push(words[i*size..(i*(size-1))])
      #lines.push(words[i*6..(i*6)+5])
    end
=end
    lines = Array.new
    paragraph = String.new
    size -= 2
    len = text.to_s.length

    int_groups = len / size
    int_groups.times do |i|
      lines.push(text[i*size..(i*size)+size-1])
    end
    if len % size != 0
      lines.push(text[(size*int_groups)..-1])
    end

    lines.each do |i|
      begin
        paragraph += "#{box(i, size + 2)}\n"
      rescue
      end
    end
    return paragraph[0..-2]
  end

  def format(args)
    if args[0][:who] != args[1]
      size = 0; else
      size = args[3] - args[4] * 2
    end
    return <<~HEREDOC.split("\n").map{ |i| " "*(size) + i}.join("\n")
      ╭#{"─"*(args[4] - 2)}╮
      #{box("#{args[0][:who].to_s} │ #{args[0][:date].to_s}", args[4])}
      ├#{"─"*(args[4] - 2)}┤
      #{align(args[0][:text], args[4])}
      ╰#{"─"*(args[4] - 2)}╯
    HEREDOC
  end

  def push(*args)
    # args => :msg_hash, :sender, :file_name, :body_size, :msg_size
    #     [      ^ 0       ^ 1        ^ 2        ...               ]

    File.open("#{args[2]}.txt", "a") do |f|
      begin $i+=1; rescue
        f.truncate(0); $i=0
      end
      f.write(
        format(args) + "\n\n"
      )
    end
  end
end
=begin
module Regex
  def date(s)
    return ""
  end
end
=end
