#!/usr/bin/env python3

import argparse


def parse_args():
    parser = argparse.ArgumentParser(
        description="Convert list of comma separated values into Q3.13 format.")
    parser.add_argument('input', help='Input file name')
    parser.add_argument('outputFeatures', help='Output file name with features')
    parser.add_argument('outputClasses', help='Output file name with classes')

    return parser.parse_args()

def load_instances(filename):
    class_converter = {
        'Iris-setosa' : '00',
        'Iris-versicolor' : '01',
        'Iris-virginica' : '10'
    }

    with open(filename, 'r') as f:
        raw_lines = f.readlines()

    instances = []

    for l in raw_lines:
        line = l.strip()
        params = line.split(',')
        instance = (
            (
                float(params[0]),
                float(params[1]),
                float(params[2]),
                float(params[3])
            ),
            (
                format(round(float(params[0])*(2**13)), '04X'),
                format(round(float(params[1])*(2**13)), '04X'),
                format(round(float(params[2])*(2**13)), '04X'),
                format(round(float(params[3])*(2**13)), '04X')
            ),
            (
                params[4],
                class_converter[params[4]]
            )
        )
        instances.append(instance)

    return instances

def dump_contents(instances, features_filename, classes_filename):

    features_file_content = []
    classes_file_content = []

    for instance in instances:
        features_file_content.append("".join(instance[1]))
        classes_file_content.append(instance[2][1])

    with open(features_filename, 'w+') as f:
        f.write('memory_initialization_radix=16;\n')
        f.write('memory_initialization_vector=\n')
        for el in features_file_content[:-1]:
            f.write("{},\n".format(el))
        f.write("{};\n".format(features_file_content[-1]))

    with open(classes_filename, 'w+') as f:
        f.write('memory_initialization_radix=2;\n')
        f.write('memory_initialization_vector=\n')
        for el in classes_file_content[:-1]:
            f.write("{},\n".format(el))
        f.write("{};\n".format(classes_file_content[-1]))


def main():
    args = parse_args()
    instances = load_instances(args.input)
    dump_contents(instances, args.outputFeatures, args.outputClasses)

if __name__ == '__main__':
    main()