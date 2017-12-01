# Data Mining (ID2222) Assignment 4
# Authors: Beatrice Ionascu (bionascu@kth.se), Diego Yus Lopez (diegoyl@kth.se)
# Last changed: 2017-12-3


import argparse
import itertools
import os


def parse_arguments():
    """
    Parse command line arguments.
    :return: parsed arguments
    """
    parser = argparse.ArgumentParser(description='Running main.py')

    parser.add_argument('-s', type=float, default=0.01,
                        help='support threshold (default s = 0.01)')
    parser.add_argument('-c', type=float, default=0.50,
                        help='confidence threshold (default c = 0.50)')
    parser.add_argument('-d', type=str, default=None,
                        help='data path (default = \'/data/example1.dat\')')
    arguments = parser.parse_args()

    return arguments.s, arguments.c, arguments.d


def read_data(data_path=None):
    """
    Read data.
    :param data_path: path to data
    :return: data as a list of lists
    """
    if data_path is None:
        data_path = os.path.join('..', 'data', 'example1.dat')
    with open(data_path) as f:
        data = [[int(x) for x in line.strip().split(',')] for line in f]
    return data



def run():
    """
    Run program.
    """
    # Parse arguments
    #support_threshold, confidence_threshold, data_path = parse_arguments()
    # Read data
    data = read_data()

    print('\nNumber of edges: %d' % len(data))



if __name__ == "__main__":

    run()
