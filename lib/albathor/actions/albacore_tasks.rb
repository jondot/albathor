require 'albathor/actions/core'
%w{
  aspnet
  assembly_info
  aspnet
  ncover
  nuget
  nunit
  output
  xunit
  zip
}.each{|r| require "albathor/actions/#{r}"}


