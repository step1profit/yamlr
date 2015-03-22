module Yamlr
  module Reader
    module Parser
      class IndentError < StandardError; end

      def self.parse(line, opts, num)
        results = self.parse_line(line, opts)
        phs = self.results_to_hash(results, opts)
        self.check_indent(line, phs[:spc], opts[:indent], num)
        phs
      end

      # invalid number of spaces, line num and truncated line for context
      #
      def self.check_indent(line, spc, idt, num)
        raise IndentError, "#{num} #{line[1..50]}" if spc % idt != 0
      end

      # parses line, returns array, dependent on Node module
      #
      def self.parse_line(line, opts)
        nod = Yamlr::Reader::Node
        spc = opts[:space]
        hsh = opts[:hash]
        sym = opts[:symbol]
        dcs = opts[:doc_start]
        dct = opts[:doc_term]
        arr = opts[:array]
        com = opts[:comment]

        begin
          case line
          when nod.left_match(arr, spc) then            [:arr, Regexp.last_match.captures]
          when nod.left_match(com, spc) then            [:com, Regexp.last_match.captures]
          when nod.hashkey_sym(hsh, sym, spc) then      [:hky, Regexp.last_match.captures, nil, true]
          when nod.hashkey(hsh, spc) then               [:hky, Regexp.last_match.captures]
          when nod.hashpair_sym_all(hsh, sym, spc) then [:hpr, Regexp.last_match.captures, true, true]
          when nod.hashpair_sym_key(hsh, sym, spc) then [:hpr, Regexp.last_match.captures, true]
          when nod.hashpair_sym_val(hsh, sym, spc) then [:hpr, Regexp.last_match.captures, nil, true]
          when nod.hashpair(hsh, sym, spc) then         [:hpr, Regexp.last_match.captures]
          when /^\s*$/ then                             [:bla]
          when nod.document(dcs, spc) then              [:dcs]
          when nod.document(dct, spc) then              [:dct]
          else
            raise 'MALFORMED'
          end
        rescue => e
          # log or whatever
          [:mal, '', nil, line.strip]
        end
      end

      # creates hash with array vals, includes options
      #
      def self.results_to_hash(results, opt)
        #raise results.flatten.to_s + " results.class => #{results.class}"
        msg, spc, key, val, ask, asv = results.flatten
        { :msg => msg,
          :spc => (spc.nil? ? 0 : spc.length),
          :key => key.to_s.sub(/^:/, ''),
          :val => val.to_s.sub(/^:/, ''),
          :ask => ask,
          :asv => asv,
          :opt => opt}
      end
    end
  end
end
