module BookLab::SML
  module Rules
    def self.all
      rules = []
      Dir.glob(::File.expand_path("rules/*.rb", __dir__)).each do |path|
        require path
        rule_name = ::File.basename(path, ".rb")
        next if rule_name == "base"
        rules << "BookLab::SML::Rules::#{rule_name.classify}".constantize
      end
      rules
    end
  end
end