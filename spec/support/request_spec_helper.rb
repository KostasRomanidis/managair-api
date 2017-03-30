module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  # Call it by logger.warn(:object.pretty_inspect)
  def logger
    Rails::logger
  end
end
