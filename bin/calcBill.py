#!/usr/bin/env python
# using python 3
from collections import OrderedDict
# import os
import calendar
import json

# to run this script in emacs evil-mode:
# :!python %

# water = 325.35
# electric = 0
# comcast = 66.95
# gas = 10.98

# total = water + comcast + gas + electric
# each = total / 5
# print
# print "total, " + str(total)
# print "each, " + str(each)
# print "done"
NUMBER_OF_ROOMMATES = 5
WIDTH = 29
BILLS_FILE = 'bills.json'


def migrate_bills_info():
    dict = {}
    dict['months'] = []
    current_month = OrderedDict()
    month_bills = OrderedDict()
    for line in open('bills.csv').read().split('\n'):
        if not line:
            continue
        key, val = line.split(', ')
        if key == 'month' or key == 'year':
            val = int(val)
        elif key != 'comment':
            val = float(val)
        if key in ['month', 'year', 'comment', 'each', 'total']:
            current_month[key] = val
        else:
            month_bills[key] = val

        # At the last item for the month, we save and reset our month object
        if key == 'each':
            current_month['bills'] = month_bills
            dict['months'].append(current_month)
            current_month = OrderedDict()
            month_bills = OrderedDict()
    with open('bills-migration.json', 'w') as fp:
        json.dump(dict, fp, indent=2, separators=(',', ': '))


def get_latest_bills():
    bills = json.load(open(BILLS_FILE))
    return bills['months'][len(bills['months']) - 1]
    # last_months_bills = bills['months'][len(bills['months']) - 1]
    # return last_months_bills['month'], \
    #     last_months_bills['year'], \
    #     last_months_bills['bills']


def offsetMonthIndex(month, offset):
    # Translate month to be indexed at 0
    month = month - 1
    # Mod as usual, now that we are indexed at 0
    month = (month + offset) % 12
    # Translate month to be indexed at 1
    return month + 1


# def print_last_months_bills(month, year, results):
def print_last_months_bills(monthly_data):
    month = monthly_data['month']
    year = monthly_data['year']
    monthlyTotal = monthly_data['total']
    per_person = monthly_data['each']
    print("SUBJECT:\n%s/%s Rent and %s/%s Utilities\n\n" %
          (calendar.month_abbr[month],
           calendar.month_abbr[offsetMonthIndex(month, 1)],
           calendar.month_abbr[offsetMonthIndex(month, -1)],
           calendar.month_abbr[month]))
    print("Hey all,\n")
    print("Here are the bills for this month:")
    print("\n```\n")
    print("%s/%s %s".center(WIDTH) %
          (calendar.month_abbr[month - 1],
           calendar.month_abbr[month], year))
    print('-' + '-' * WIDTH + '-')
    print("| %-18s | %6s |" % ("Utility", "Amount"))
    print('|' + '-' * WIDTH + '|')
    [print("| %-18s | %6s |" %
           (bill, monthly_data['bills'][bill]))
     for bill in monthly_data['bills']]
    print('-' + '-' * WIDTH + '-')
    print("\n```\n")
    print("**Monthly total: %.2f**" % monthlyTotal)
    # always round up by one cent
    print("**Per person: %.2f **" % per_person)
    print()
    print("Also, don't forget to deduct any common items like tp, oil, etc")
    print()
    print("Thanks,\nLuke")


def print_JSON_for_records(monthly_data):
    # Print bills for records
    print()
    print('-' * WIDTH)
    print("\nfor our records:\n")
    print(json.dumps(monthly_data, indent=2, separators=(',', ': ')))


def main():
    print("Calculating bills...\n\n")
    # get latest bills, loading the file in the order written with OrderedDict
    bills = json.load(open(BILLS_FILE), object_pairs_hook=OrderedDict)
    latest_month_data = bills['months'][len(bills['months']) - 1]
    # calculate total bills
    total = 0
    for bill in latest_month_data['bills'].values():
        total += bill
    total = round(total, 2)
    each = round((total / (float)(NUMBER_OF_ROOMMATES) + 0.01), 2)
    # If 'total' has already been calculated, print a warning statement
    old_total = latest_month_data.get('total', False)
    if old_total and old_total != total:
        print("The monthly total %.2f has been updated to %.2f"
              % (old_total, total))
        print()
    latest_month_data['total'] = total
    latest_month_data['each'] = each
    # sort our bills, and add the sorted to the end of our monthly set:
    sorted_bills = OrderedDict()
    for key in sorted(latest_month_data['bills'].keys()):
        sorted_bills[key] = latest_month_data['bills'][key]
    latest_month_data.pop('bills')
    latest_month_data['bills'] = sorted_bills
    print_last_months_bills(latest_month_data)
    print_JSON_for_records(latest_month_data)


if __name__ == "__main__":
    main()
