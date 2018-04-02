class Parser
  attr_reader :env
  def initialize
    @env = Hash.new

  end

  def format_lines(request_lines)
    first_split = request_lines[0].split(" ")
    @env["Verb"] = first_split[0]
    @env["Path"] = first_split[1]
    @env["Protocol"] = first_split[2]
    host_line = request_lines[1].split(":")
    @env["Host"] = host_line[1]
    @env["Port"] = host_line[2]
    accept_line = request_lines[5].split(" ")
    @env["Accepts"] = accept_line[1]
  end
end
