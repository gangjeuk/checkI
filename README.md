# checkI
Check file integrity before you upload your file on Cloud

checkI can make hash value list of you files and check your file integrity.

here is the usage.

```
------------help menu-------------

command list

check: verify hash of each file(default)
make: make the hash list of file
help: print this message

usage
bash check_i.sh make [dir_path]: make the hash list in dir_path
bash check_i.sh check [dir_path]: verify hash of each file
bash check_i.sh [dir_path]: same as above
```
--------------------------------------
If some of you files has been tampered you can check tampered file list.

The Warning message will be display like this

```
[file has been tampered!!!]
linux_cmd/ch12/numeric_test.sh: 587b75b455fae261ccce5f3fec741c353ca65604be1a62647af820745fe47f06 -> e909a62d1fef60b7c9894b8b5eacc3310ed4ce8aff56517880c5b371e1ad4be1
```

--------------------------------------
Most cloud services do not provide the integrity check service. 

However, some of your files such as pictures, text may be preproccessed by the cloud service provider for efficient compressure or something.

It may affect to your metadata of your file.

So if you want to check your file integrity, make a hash list with my checkI before you upload your file on Cloud
