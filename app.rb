require 'functions_framework'
FunctionsFramework.http('hello') do |_request|
  "Hello, world!\n"
end
