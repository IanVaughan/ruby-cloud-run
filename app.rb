require 'functions_framework'

FunctionsFramework.http('helloruby') do |_request|
  "Hello, world!\n"
end
