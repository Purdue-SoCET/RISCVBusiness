
import argparse
from run_riscv_tests import Colors
from run_riscv_tests import run_selected_tests
import subprocess
import sys
import yaml

CONFIG_PATH = 'example.yml'


def parse_args():
  """Parses the arguments for the script."""
  parser = argparse.ArgumentParser(
      prog='RISC-V Tests',
      description='Runner for RISCVBusiness Test Suite. Leaving arguments empty will run all test types. Specifying arguments will run only those tests types.',
  )
  parser.add_argument(
      '--sim-parallel',
      action='store_true',
      help='Enable parallel simulation of tests where possible.'
  )
  parser.add_argument(
      '--num-harts',
      default=1,
      type=int,
      help='Specify how many harts to run. Defaulted to 1. By default, one hart runs occur first. If multihart is needed, specify NUM_HARTS > 1.'
  )
  parser.add_argument(
      '--riscv-tests',
      action='store_true',
      help='Run all riscv-tests.'
  )

  # TODO(anyone): implement embench, please!
  parser.add_argument(
      '--embench',
      action='store_true',
      help='Run all embench tests.'
  )

  args = parser.parse_args()
  
  # If num_harts is less than 1, set it to 1
  if args.num_harts < 1:
    args.num_harts = 1

  # If no tests were singled out,
  # set all of the tests to True.
  if not (
      args.riscv_tests
      | args.embench
  ):
    args.riscv_tests = True
    args.embench = True
  return args


def status_print(out, end='\n', color=Colors.CYAN):
  """Status printer wrapper."""
  print(f'{color}{out}{Colors.END}', end=end)


def load_configuration(file_name):
  """Loads the YAML file at the path in `file_name`."""
  with open(file_name, 'r') as f:
    try:
      config = yaml.full_load(f)
    except yaml.parser.ParserError:
      sys.exit('Parse of '+ file_name + ' failed. Please check yml syntax')
  return config


def save_configuration(file_name, config):
  """Saves the YAML config to the path in `file_name`."""
  with open(file_name, 'w') as f:
    try:
      yaml.dump(config, f, default_flow_style=False, sort_keys=False)
    except yaml.parser.ParserError as y:
      status_print(y, color=Colors.RED)
      sys.exit('Write of '+ file_name + ' failed.')


def config_maxed_core(config_path, num_harts=2):
  """Configures the RISC-V core to its maximum ISA support."""
  # load in the config for the core.
  config = load_configuration(config_path)

  # Configuring ISA Parameters
  # We want the following:
  # - PMP granularity 4B
  # - Supervisor enabled
  # - Address translation enabled
  # - ISA string to include M & A
  isa_params = config['isa_params']
  isa_params['pmp_minimum_granularity'] = '4'
  isa_params['supervisor'] = 'enabled'
  isa_params['address_translation'] = 'enabled'
  isa_params['isa'] = 'rv32imacbzifencei_zicsr'
  config['isa_params'] = isa_params

  # Configuring Microarch Params
  # We want the following:
  # - 2 harts minimum
  microarch_params = config['microarch_params']
  microarch_params['num_harts'] = num_harts
  config['microarch_params'] = microarch_params

  # save the config
  save_configuration(config_path, config)

  # clean the core
  try:
    status_print('Cleaning the core...')
    res = subprocess.run(
        'make clean && ccache -C',
        shell=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        universal_newlines=True,
    )
    print(res.stdout)
    status_print('Cleaning the core succeeded.', color=Colors.GREEN)
  except Exception as e:
    status_print('\nCleaning the core failed.', color=Colors.RED)
    print(e)
    sys.exit(1)

  # build the core
  try:
    status_print('Building the core...')
    res = subprocess.run(
        ['make', 'verilate'],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        universal_newlines=True,
    )
    print(res.stdout)
    status_print('Building the core succeeded.', color=Colors.GREEN)
  except:
    print('\nBuilding the core failed.', color=Colors.RED)
    sys.exit(1)


def riscv_tests_runner(num_harts, sim_parallel=False):
  """Wrapper for running riscv-tests."""
  run_selected_tests(
      machine_mode_tests=True,
      supervisor_mode_tests=True,
      sim_parallel=sim_parallel,
  )
  run_selected_tests(
      isa=['i', 'm', 'a', 'c', 'zba', 'zbb', 'zbs'],
      envs=['p'],
      sim_parallel=sim_parallel,
  )
  run_selected_tests(
      isa=['i', 'm', 'c', 'zba', 'zbb', 'zbs'],  # currently, 'a' is not supported in env 'v'
      envs=['v'],
      sim_parallel=sim_parallel,
  )
  if num_harts == 1:
    run_selected_tests(
        benchmark_tests=True,
        sim_parallel=sim_parallel,
    )


def main():
  """Main function."""
  args = parse_args()

  if args.riscv_tests:
    # 1-hart tests
    # benchmarks are only supported in single core
    status_print("1-hart riscv-tests")
    config_maxed_core(CONFIG_PATH, num_harts=1)
    riscv_tests_runner(num_harts=1, sim_parallel=args.sim_parallel)

    # do another test run with the specifed number of harts
    if args.num_harts > 1:
      status_print(f"{args.num_harts}-hart riscv-tests")
      config_maxed_core(CONFIG_PATH, num_harts=args.num_harts)
      riscv_tests_runner(num_harts=args.num_harts, sim_parallel=args.sim_parallel)
      

  
  if args.embench:
    """TODO(anyone): add in support for embench."""

if __name__ == "__main__":
  main()