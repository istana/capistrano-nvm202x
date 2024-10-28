namespace :nvm do
  task :validate do
    on release_roles(fetch(:nvm_roles)) do |host|
      nvm_node = fetch(:nvm_node)
      if nvm_node.nil?
        info 'nvm: nvm_node is not set; node version will be defined by the remote hosts via nvm'
      end

      # don't check the nvm_node_dir if :nvm_node is not set (it will always fail)
      unless nvm_node.nil? || (test "[ -d #{fetch(:nvm_node_dir)} ]")
        warn "nvm: #{nvm_node} is not installed or not found in #{fetch(:nvm_node_dir)} on #{host}"
        exit 1
      end
    end
  end

  task :map_bins do
    nvm_binaries_path = "#{fetch(:nvm_node_dir)}/bin/"

    SSHKit.config.default_env.merge!({
      nvm_root: fetch(:nvm_path),
      node_version: fetch(:nvm_node),
      path: "#{nvm_binaries_path}:$PATH",
    })

    # cssbundling or anything calling yarn directly won't trigger this
    # only running yarn via sshkit
    fetch(:nvm_map_bins).uniq.each do |command|
      SSHKit.config.command_map[command.to_sym] = "#{nvm_binaries_path}/#{command}"
    end
  end
end

Capistrano::DSL.stages.each do |stage|
  after stage, 'nvm:validate'
  after stage, 'nvm:map_bins'
end

namespace :load do
  task :defaults do
    set :nvm_path, -> {
      nvm_path = fetch(:nvm_custom_path)
      nvm_path ||= case fetch(:nvm_type, :user)
      when :system
        '/usr/local/opt/nvm'
      else
        '$HOME/.nvm'
      end
    }

    set :nvm_roles, fetch(:nvm_roles, :all)

    set :nvm_node_dir, -> { "#{fetch(:nvm_path)}/versions/node/#{fetch(:nvm_node)}" }
    set :nvm_map_bins, %w{corepack node npm npx yarn yarnpkg}
  end
end
