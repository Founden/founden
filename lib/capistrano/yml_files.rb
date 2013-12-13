module ::Capistrano::DSL::YamlFiles
  # Its like `ask` but stateless
  def ask_for_value(key, default)
    question = ::Capistrano::Configuration::Question.new(self, key, default)
    yield question
  end

  # Creates the file based on existing example YAML file
  def yml_file(file_path)
    file_name = File.basename(file_path)
    example_file = File.expand_path(
      '../../../config/' + file_name + '.example', __FILE__)

    puts 'Creating file %s using %s' % [file_name, example_file]
    puts '...'

    reading_example(example_file) do |hash|
      File.write(file_path, hash.to_yaml)
    end
  end

  # Reads an example file and asks if its values need to be changed
  def reading_example(yml_example_file)
    yml_env = fetch(:stage).to_s
    yml_hash = YAML.load_file(yml_example_file)
    yml_hash[yml_env].each do |key, val|
      unless val.is_a? Hash
        ask_for_value(key, val) do |answer|
          yml_hash[yml_env][key] = answer.call
        end
      end
    end
    yield yml_hash.slice(yml_env)
  end
end

include ::Capistrano::DSL::YamlFiles
