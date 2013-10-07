require 'chefspec'
require 'berkshelf'

Berkshelf.ui.mute do
  Berkshelf::Berksfile.from_file('Berksfile').install(path: 'vendor/cookbooks/')
end

RSpec.configure do |c|
  c.after(:suite) do
    FileUtils.rm_rf('vendor/')
  end
end
