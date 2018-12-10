MoneyRails.configure do |config|
  config.default_currency = :eur  # or :gbp, :usd, etc.
  config.default_format = {
      :subunit             => "Subcent",
      :subunit_to_unit     => 10000,
      :thousands_separator => " ",
      :decimal_mark        => ","
    }
end
