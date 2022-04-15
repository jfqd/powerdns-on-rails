class BigDecimal
  # Needed to support Ruby 1.9.x, as it doesn't allow dup on BigDecimal, instead
  # raises TypeError exception. Checking here on the runtime whether BigDecimal
  # will allow dup or not.
  begin
    BigDecimal('4.56').dup

    def duplicable?
      true
    end
  rescue TypeError
    # can't dup, so use superclass implementation
  end
end

module JSON
  module_function

  def parse(source, opts = {})
    Parser.new(source, **opts).parse
  end
end