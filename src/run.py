#!/bin/env python3

import sys


def test():
    print("test(): Not implemented")
    sys.exit(1)


def main():
    print("main(): Not implemented")
    sys.exit(1)


if __name__ == '__main__':
    if len(sys.argv) >= 2 and sys.argv[1] == 'test':
        test()
    else:
        main()
