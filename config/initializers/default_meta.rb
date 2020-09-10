# Initialize default meta tags.
DEFAULT_META = YAML.load_file(File.join(File.dirname("config/meta.yml"), 'meta.yml'))
# YAML.load_file(Rails.root.join("config/meta.yml"))