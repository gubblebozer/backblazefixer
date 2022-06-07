# backblazefixer

After years of entrusting my backup process to Backblaze, I learned the hard way that they don't store 
UNIX file attributes.  Here's two simple utilities that helped me regain some of what I lost.

* `backblazefixer.sh`: does a `chmod +x` on files that `file(1)` identifies as executables.
* `gitfix.sh`: for files in git repos with local changes, does `git diff` to determine mode differences, then `chmod`s the files accordingly.

Examples:

```
backblazefixer +x *
```

```
git status -s | grep ' M ' | awk '{print $2}' | xargs gitfix.sh
```
