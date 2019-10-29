# This will schedule our jobs
class Scheduler
  attr_reader :graph

  def initialize(input_file_path = './input.json')
    input_file = File.open input_file_path
    @input = JSON.load input_file
    @graph = RGL::DirectedAdjacencyGraph.new
    @graph.add_vertex 'root'
    @parents = {}
  end

  def tell_order
    make_graph
    raise Errors::CircularDependency unless @graph.cycles.empty?

    @graph.dfs_iterator.to_a.reverse[0..-2]
  end

  private

  def make_graph
    @input.each do |vertex1, vertex2|
      if vertex2.nil?
        @graph.add_edge('root', vertex1) unless parent_exists?(vertex1)
      else
        raise Errors::ItselfDependent if vertex1.eql?(vertex2)

        add_dependency(vertex1, vertex2)
      end
    end
  end

  def parent_exists?(vertex)
    !@parents[vertex].nil?
  end

  def add_dependency(vertex1, vertex2)
    @graph.add_edge(vertex1, vertex2)
    @graph.remove_edge('root', vertex2)
    @graph.add_edge('root', vertex1) unless parent_exists?(vertex1)
    @parents[vertex2] = vertex1
  end
end
