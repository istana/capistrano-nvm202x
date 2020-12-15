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
    SSHKit.config.default_env.merge!({ nvm_root: fetch(:nvm_path), nvm_version: fetch(:nvm_node) })
    nvm_prefix = fetch(:nvm_prefix, proc { "#{fetch(:nvm_path)}/nvm-exec" })
    SSHKit.config.command_map[:nvm] = "#{fetch(:nvm_path)}/nvm.sh"

    fetch(:nvm_map_bins).uniq.each do |command|
      SSHKit.config.command_map.prefix[command.to_sym].unshift(nvm_prefix)
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
      when :fullstaq
        '/usr/lib/nvm'
      else
        '$HOME/.nvm'
      end
    }

    set :nvm_roles, fetch(:nvm_roles, :all)

    set :nvm_node_dir, -> { "#{fetch(:nvm_path)}/versions/node/#{fetch(:nvm_node)}" }
    set :nvm_map_bins, %w{rake gem bundle yarn rails}
  end
end
