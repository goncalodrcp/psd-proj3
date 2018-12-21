#!/usr/bin/env python3

import argparse


def parse_args():
    parser = argparse.ArgumentParser(
        description="Convert list of comma separated values into Q3.13 format.")
    parser.add_argument('trainInput', help='Input file name with train instances')
    parser.add_argument('testInput', help='Input file name with test instances')
    parser.add_argument('output', help='Output file name with classification results')
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
                round(float(params[0])*(2**13)),
                round(float(params[1])*(2**13)),
                round(float(params[2])*(2**13)),
                round(float(params[3])*(2**13))
            ),
            (
                params[4],
                class_converter[params[4]]
            )
        )
        instances.append(instance)

    return instances


def difference_instance_features(train_instance, test_instance):

    train_instance_features_f = train_instance[0]
    test_instance_features_f = test_instance[0]

    train_instance_features_q = train_instance[1]
    test_instance_features_q = test_instance[1]

    diff_f = sum([(a - b)**2 for (a, b) in zip(train_instance_features_f, test_instance_features_f)])
    diff_q = sum([(a - b)**2 for (a, b) in zip(train_instance_features_q, test_instance_features_q)])

    return [diff_f, diff_q, train_instance[2]]


def classify_instance(train_instances, test_instance):
    distances = []
    for train_instance in train_instances:
        distances.append(difference_instance_features(train_instance, test_instance))

    distances_sorted_f = sorted(distances, key=lambda x:x[0])
    distances_sorted_q = sorted(distances, key=lambda x:x[1])

    return [distances_sorted_f[0:5], distances_sorted_q[0:5]]


def classify_set(train_instances, test_instances):
    classification_data = {}
    for test_instance in test_instances:
        classification_data[test_instance] = classify_instance(train_instances, test_instance)
    return classification_data


def dump_contents(results, filename):

    with open(filename, 'w+') as f:
        for k, v in results.items():
            features_f = " {},{},{},{}".format(k[0][0], k[0][1], k[0][2], k[0][3])
            features_q = "{}{}{}{}".format(
                format(k[1][0], '04X'),
                format(k[1][1], '04X'),
                format(k[1][2], '04X'),
                format(k[1][3], '04X')
            )

            classes_3_f = [a[2][1] for a in v[0][0:3]]
            classes_5_f = [a[2][1] for a in v[0][0:5]]

            classes_3_q = [a[2][1] for a in v[1][0:3]]
            classes_5_q = [a[2][1] for a in v[1][0:5]]

            count_3_f = [classes_3_f.count('00'), classes_3_f.count('01'), classes_3_f.count('10')]
            count_5_f = [classes_5_f.count('00'), classes_5_f.count('01'), classes_5_f.count('10')]

            count_3_q = [classes_3_q.count('00'), classes_3_q.count('01'), classes_3_q.count('10')]
            count_5_q = [classes_5_q.count('00'), classes_5_q.count('01'), classes_5_q.count('10')]

            if count_3_f.index(max(count_3_f)) == 0:
                class_3_f = '00'
            elif count_3_f.index(max(count_3_f)) == 1:
                class_3_f = '01'
            elif count_3_f.index(max(count_3_f)) == 2:
                class_3_f = '10'

            if count_5_f.index(max(count_5_f)) == 0:
                class_5_f = '00'
            elif count_5_f.index(max(count_5_f)) == 1:
                class_5_f = '01'
            elif count_5_f.index(max(count_5_f)) == 2:
                class_5_f = '10'

            if count_3_q.index(max(count_3_q)) == 0:
                class_3_q = '00'
            elif count_3_q.index(max(count_3_q)) == 1:
                class_3_q = '01'
            elif count_3_q.index(max(count_3_q)) == 2:
                class_3_q = '10'

            if count_5_q.index(max(count_5_q)) == 0:
                class_5_q = '00'
            elif count_5_q.index(max(count_5_q)) == 1:
                class_5_q = '01'
            elif count_5_q.index(max(count_5_q)) == 2:
                class_5_q = '10'

            f.write("{} : {} | {} (k=1) : {} (k=3) : {} (k=5)\n".format(
                features_f, k[2][1], v[0][0][2][1], class_3_f, class_5_f)
            )

            f.write("{} : {} | {} (k=1) : {} (k=3) : {} (k=5)\n".format(
                features_q, k[2][1], v[1][0][2][1], class_3_q, class_5_q)
            )

def main():
    args = parse_args()
    training_instances = load_instances(args.trainInput)
    test_instances = load_instances(args.testInput)
    classification_data = classify_set(training_instances, test_instances)
    dump_contents(classification_data, args.output)


if __name__ == '__main__':
    main()

