from asyncio import subprocess
from distutils.ccompiler import gen_lib_options
import os
import glob
import pathlib
import subprocess

if __name__ == "__main__":
  censor_files = []
  censor_files.append(glob.glob("./vf*.S"))
  #censor_files.append(glob.glob("./vss*.S"))
  #censor_files.append(glob.glob("./vaa*.S"))

  for filename in censor_files:
    file = pathlib.Path(filename)
    os.rename(file.name, "_"+file.name)
