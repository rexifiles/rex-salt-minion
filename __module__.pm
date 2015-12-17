package Rex::Salt::Minion; 
use Rex -base;
use Rex::Ext::ParamLookup;

# Usage: rex setup master_finger=a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1
# Usage: rex remove

# Changed this deployment to use agent-auth


desc 'Set up salt-minion agent';
task 'setup', sub { 

	my $master_finger = param_lookup "master_finger";

	unless ($master_finger) {
		say "No master ID defined. Define master_finger=a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1";
		exit 1;
	};

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

 	};

        file "/etc/salt/minion.d/masterfinger.conf",
               	content => template("files/etc/minion.d/masterfinger.tmpl", conf => { master_finger => "$master_finger" }),
               	on_change => sub { 
                       	say "master fingerprint added or updated. ";
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
