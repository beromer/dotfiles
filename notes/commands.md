a````
export KOKKOS_PROFILE_LIBRARY={PATH_TO_TOOL_DIRECTORY}/kp_hwm.so
````

nvprof metrics (load/store counts fp instruction counts etc)
`nvprof --metrics all command`

linux tee (print to stdout and file)
`some_command | tee file.txt`

cmake flag to gernerate compile commands
`-DCMAKE_EXPORT_COMPILE_COMMANDS=on`

## Fiesta on Chicoma
```
module swap PrgEnv-cray PrgEnv-gnu
module load cmake
module load cray-hdf5-parallel
module load cuda/11.6
```

```
cmake ../fiesta -DCMAKE_C_COMPILER="cc" -DCMAKE_CXX_COMPILER="CC" -DFiesta_CUDA=on -DFiesta_BUILD_ALL=on -DFiesta_BUILD_TESTS=on -DKokkos_ARCH_AMPERE80=on
```

For `gpu-aware` see:
https://docs.nersc.gov/systems/perlmutter/#gpu-aware-mpi

Chicoma Training Materials
https://github.com/maxpkatz/lanl_nvidia_training

## Recursive Restarts
```
retval=$?
if [ $retval -ne 0 ]; then
    if test -f "RECURSIVE"; then
        echo "Running again."
        sbatch run.sh
    else
        echo "Cancelling recursion."
    fi
else
    echo "Done."
fi

```

## c++ address sanitizer
-fsanitize=address

## Clone a repo with submodules
`git clone --resurse-submodules https://github.com/name/repo`

## Add a submodule
`git submodule add https://github.com/name/repo`

## Fix Python after 'brew upgrade'
````
brew unlink python@3.9
brew unlink python@3.10
brew link --force python@3.10
````

$\alpha=x_1^{2}$

## example of encoding lua table into json
requires lunajson library (can be installed with luarocks)
```
luna = require 'lunajson'

fiesta.metadata = luna.encode({
    ["frequency"] = fiesta.status.frequency,
    ["R"] = fiesta.eos.R
})
```
or with string format:
```
fiesta.metadata = string.format('{"frequency":%d,"R":%f}',fiesta.status.frequency,fiesta.eos.R)
```

## example of reading json with python
```
import json
a = '{"R":8.3144620000000007,"frequency":500}'
b = json.loads(a)
print(b["R"])
# 500
```

## slurm get job info
`scontrol show jobid ######`

## Create a repo with gh
```
git init
git add ...
git commit

gh repo create repo_name -d "Repo Description" --disable-issues --disable-wiki --private --source=. --remote=upstream

git push --set-upstream upstream main
```

## copy pattern of files from chicoma
```
rsync -Phavz --delete --include="vert-*0000.*" --include="*/" --exclude="*" -e "ssh wtrw.lanl.gov ssh" ch-fe.lanl.gov:s5/3dsdkhi/jfmruns/sdkhv_30/vertical .
```

## setup piv for chicoma/turquoise
Inatall `https://github.com/kenh/keychain-pkcs11/releases'

```
Host wtrw
    HostName wtrw.lanl.gov
    User beromer
    IdentityFile /usr/local/lib/keychain-pkcs11.dylib
    PKCS11Provider /usr/local/lib/keychain-pkcs11.dylib
    ForwardX11Trusted yes
    ForwardAgent yes
    ForwardX11 yes
    RequestTTY yes

Host ch
    HostName wtrw.lanl.gov
    User beromer
    IdentityFile /usr/local/lib/keychain-pkcs11.dylib
    PKCS11Provider /usr/local/lib/keychain-pkcs11.dylib
    ForwardX11Trusted yes
    ForwardAgent yes
    ForwardX11 yes
    RequestTTY yes
    RemoteCommand ssh ch-fe1

```

### ssh to chicoma
`ssh ch`
### scp from chicoma
```
scp wtrw:ch-fe:~/file/name .
```
### rsync from chicoma
```
rsync -Phavz -e "ssh wtrw ssh" ch-fe:path/to/source .
```

## command to set remote after gh repo creation
```
git push --set-upstream upstream main
```

## Remove duplicate bibtex entries
```
bibtool -- 'print.deleted.entries = off' -d foo.bib -o foo-nodup.bib
```

## gh repo access token
`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`


## create blank image with cli
Blank white imge
Blank white imges
`convert -size 200x200 xc:white canvas.png`

Random noisy image, 80% black, 20% white
```
convert -size 1000x1000 xc: +noise Random -channel R -separate +channel -threshold 80% -print %[fx:mean] x.png
```

## fix h5py after brew update
This used to be necessary on M1 macs but doesn't seem to be needed anymore

This is necessary after upgrading hdf5-mpi during a brew upgrade.
```
pip uninstall h5py
export HDF_DIR=/opt/homebrew/Cellar/hdf5-mpi/<version>/
export CC=mpicc
pip install --no-binary=h5py h5py
```

