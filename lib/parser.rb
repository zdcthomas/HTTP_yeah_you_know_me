require 'pry'
class Parser
  attr_reader :env
  def initialize
    @env = Hash.new

  end

  def format_lines(request_lines)
    first_line = request_lines[0].split(" ")
    @env["Verb"] = first_line[0]
    @env["Path"] = first_line[1].split("?").first
    # binding.pry
    unless first_line[1].split("?")[1].nil?
      @env["Parameter"] = first_line[1].split("?")[1].split("=")[0]
      @env["Value"] = first_line[1].split("?")[1].split("=")[1]
    end
    
    @env["Protocol"] = first_line[2]
    host_line = request_lines[1].split(":")
    @env["Host"] = host_line[1]
    @env["Port"] = host_line[2]
    accept_line = request_lines[5].split(" ")
    @env["Accepts"] = accept_line[1]
    @env
  end

  def diagnostic
    "<pre>\nVerb: #{@env["Verb"]}\nPath: #{@env["Path"]}\nProtocol: #{@env["Protocol"]}\nHost: #{@env["Host"]}\nPort: #{@env["Port"]}\nAccepts: #{@env["Accepts"]}\n"
  end

end
