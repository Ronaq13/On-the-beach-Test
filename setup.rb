require 'rgl/adjacency'
require 'rgl/traversal'
require 'json'
require 'byebug'
require_relative './lib/scheduler'
require_relative './lib/errors/circular_dependency'
require_relative './lib/errors/itself_dependent'