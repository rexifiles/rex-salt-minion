# rex-salt-minion

## setup()
Will add the repo and salt monion application to the designated machines. 

## clean()
Will remove the salt package


```
task "setup", make {

  Rex::Salt::Minion::setup(server="SE.RV.ER.IP"); # To be decided. 

};
```

```
task "clean", make {

  Rex::Collectd::Base::clean();

};
```


# Salt minion
The salt minion repository and package will be installed. Configuration to come afterwards. 
```
N/A
```

