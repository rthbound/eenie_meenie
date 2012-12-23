require "eenie_meenie/base"
#require "eenie_meenie/miny_moe"
#require "eenie_meenie/sorters/round_robin"
#require "eenie_meenie/sorters/pure_random"
#require "eenie_meenie/sorters/pick_a_group"
#require "eenie_meenie/version"
#require "eenie_meenie/result"

Dir.glob(File.join(File.dirname(__FILE__), '/**/*.rb')) do |c|
  require(c)
end
