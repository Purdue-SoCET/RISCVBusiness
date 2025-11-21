class Colors:
    class Regular:
        BLACK = '\033[0;30m'
        RED = '\033[0;31m'
        GREEN = '\033[0;32m'
        YELLOW = '\033[0;33m'
        BLUE = '\033[0;34m'
        PURPLE = '\033[0;35m'
        CYAN = '\033[0;36m'
        WHITE = '\033[0;37m'

    class Bold:
        BLACK = '\033[1;30m'
        RED = '\033[1;31m'
        GREEN = '\033[1;32m'
        YELLOW = '\033[1;33m'
        BLUE = '\033[1;34m'
        PURPLE = '\033[1;35m'
        CYAN = '\033[1;36m'
        WHITE = '\033[1;37m'

def status_print(out, end='\n', color=Colors.Bold.WHITE, file=None):
    """Status printer wrapper."""
    print(f'{color}{out}{Colors.Regular.WHITE}', end=end, file=file)

def info_print(out, end='\n', color=Colors.Bold.CYAN, file=None):
    """Info printer wrapper"""
    status_print('[INFO] ' + out, end=end, color=color, file=file)
