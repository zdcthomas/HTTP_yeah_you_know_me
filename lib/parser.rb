class Parser
  attr_reader :env
  def initialize
    @env = Hash.new

  end

  def format_lines(request_lines)
    format_first_line(request_lines)
    request_lines[1..-1].each do |line|
      split_line = line.split(" ")
      @env[split_line[0].delete(":")] = split_line[1]
    end
    @env["Port"] = @env["Host"].split(":")[1]
    @env["Host"] = @env["Host"].split(":")[0]
    @env
  end

  def format_first_line(request_lines)
    first_line = request_lines[0].split(" ")
    @env["Verb"] = first_line[0]
    @env["Path"] = first_line[1].split("?").first
    @env["Protocol"] = first_line[2]
    unless first_line[1].split("?")[1].nil?
      @env["Parameter"] = first_line[1].split("?")[1].split("=")[0]
      @env["Value"] = first_line[1].split("?")[1].split("=")[1]
    end
  end

  def diagnostic
    env = "<pre>\n"
    @env.each_pair{|key, value| env += "#{key}: #{value}\n" }
    env += "</pre>"
  end
  
end
