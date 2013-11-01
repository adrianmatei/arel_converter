module ArelConverter
  module Translator
    class Association < Base

      def process_call(exp)
        #if exp.size > 3
          #old_options = exp.pop
          #old_options.shift # 
          #new_options = [:hash]
          #new_scopes  = [:hash]
          #old_options.each_slice(2) do |key,value|
            #if option_nodes.include?(key)
              #new_options += [key, value]
            #else
              #new_scopes += [key, value]
            #end
          #end
          #@scopes  = Options.translate(Sexp.from_array(new_scopes)) unless new_scopes == [:hash]
          #@options = process(Sexp.from_array(new_options)) unless new_options == [:hash]
        #end
        super
      end

      def process_hash(exp) # :nodoc:
        @options = []
        scopes = [:hash]

        until exp.empty?
          lhs = exp.shift
          rhs = exp.shift
          if option_nodes.include?(lhs)
            lhs = process(lhs)
            t   = rhs.first
            rhs = process rhs
            rhs = "(#{rhs})" unless [:lit, :str].include? t # TODO: verify better!

            @options << "#{lhs.sub(':','')}: #{rhs}"
          else
            scopes += [lhs, rhs]
          end
        end
        @options = nil if @options.empty?
        @scopes  = Options.translate(Sexp.from_array(scopes)) unless scopes == [:hash]
        return ''
      end

      def post_processing(new_scope)
        new_scope.gsub!(/has_(many|one)\((.*)\)$/, 'has_\1 \2')
        [new_scope, format_scope(@scopes), @options].compact.join(', ')
      end

    protected

      def format_scope(scopes)
        return nil if scopes.nil? || scopes.empty?
        "-> { #{scopes.strip} }" unless scopes.nil? || scopes.empty?
      end

      def option_nodes
        [
          s(:lit, :as),
          s(:lit, :autosave),
          s(:lit, :class_name),
          s(:lit, :dependent),
          s(:lit, :foreign_key),
          s(:lit, :inverse_of),
          s(:lit, :primary_key),
          s(:lit, :source),
          s(:lit, :source_type),
          s(:lit, :through),
          s(:lit, :validate)
        ]
      end

    end
  end
end

