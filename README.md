# rex-salt-minion

## setup()
Will add the repo and salt monion application to the designated machines. 

You need to pass the fingerprint of the master. 

## clean()
Will remove the salt package


```
task "setup", make {

  Rex::Salt::Minion::setup(master_finger="a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1:a1"); 

};
```

```
task "clean", make {

  Rex::Collectd::Base::clean();

};
```


# Salt minion

## Pre-deployment
You will need to pass the fingerprint ID of the master to ensure communications are as expected. 

### Salt master:
```
salt-key -F master
```
This is the jey you will need. 


## Salt's deployed, what next?

Once the salt monion is deployed, the first thing it does is try to resolve "salt" from DNS. In the event you're not able to add 
in the name to your namesevers, you'll want to add in the entry to the "/etc/hosts" directory. 

```
N/A
```

