If you use rsync on a regular basis to sync between computers or to flash drives or hard disks, this script can help.

# How it works
- First you define your locations in the _locations.csv_ file.
  + A name for each location and device, and the path for that location.
- Contents of _locations.csv_
  + The first row is a header. You can add the name of your devices here from the second column onwards.
  + From the second row onwards, give each location a name in the first column, and then its full path from the second column onwards.
  + Put the path in the right column below your devices. Leave the others blank.
  + Since rsync works over the network, you can provide the path with the username and ipaddress/hostname too. See _locations.csv_ for examples.

# Usage
- Use `./syncer -h` to get help
- Use `./syncer -l` to get the list of device names in _locations.csv_.
- Use `./syncer -n` to get folder names in _locations.csv_.
- Default usage is: `./syncer.sh <function> <folder-name> <source-device> <target-device>`
- _function_ is either _dryrun_, _copy_, or _copy-delete_.
  + _dryrun_ is rsync's dryrun. Doesn't actually copy. Just shows you what it is going to do.
  + _copy_ is copy. But this does not delete files in target which are not present in source.
  + _copy-delete_ is copy and delete filtes in target which are not in source.
- _folder-name_, _source-device_ and _target-device_ are based on your entries in _locations.csv_.
