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

## Salt's deployed, what next?

Once the salt monion is deployed, the first thing it does is try to resolve "salt" from DNS. In the event you're not able to add 
in the name to your namesevers, you'll want to add in the entry to the "/etc/hosts" directory. 

```
N/A
```

