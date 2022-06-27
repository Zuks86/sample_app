class ApplicationController < ActionController::Base
  def hello
    render html: "hello, world!"
  end

  def bye
    render html: "bye, world!"
  end
end
