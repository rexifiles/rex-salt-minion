package Rex::Salt::Minion; 
use Rex -base;
use Rex::Ext::ParamLookup;

# Usage: rex setup # server=192.1.2.3
# Usage: rex remove

# Changed this deployment to use agent-auth


desc 'Set up salt-minion agent';
task 'setup', sub { 

	# my $server = param_lookup "server";

	# unless ($server) {
		# say "No server defined. Define server=10.10.10.10";
		# exit 1;
	# };

	unless ( is_installed("salt-minion") ) {

		repository "add" => "salt",
			url      => "http://repo.saltstack.com/apt/debian/8/amd64/latest",
			key_url  => "https://repo.saltstack.com/apt/debian/8/amd64/latest/SALTSTACK-GPG-KEY.pub",
			distro    => "jessie",
			repository => "main",
			source    => 0;

		update_package_db;

		pkg "salt-minion",
			ensure    => "latest",
			on_change => sub { say "package was installed/updated"; };

		service "salt-minion" => "restart";
 	};

	service "salt-minion" => ensure => "started";

	my $finger_id = run q!/usr/bin/salt-call --local key.finger!; 
	my $hostname = run q!hostname -f!; 
	say "$hostname : $finger_id";
};

desc 'Remove salt-minion agent';
task 'clean', sub {

	if ( is_installed("salt-minion") ) {
		service "salt-minion" => "stopped";
		remove package => "salt-minion";
		repository remove => "salt";
	};


}
