#!/usr/bin/env python
# using python 3
from collections import OrderedDict
import os
import calendar

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


def read_CSV_info():
    month = "INVALID"
    year = "INVALID"
    results = {}
    for line in readlines_reverse('bills.csv'):
        # ignore blank lines
        if ", " not in line:
            print("WARNING: weird line: " + line)
            continue
        if line.startswith("total") or line.startswith("each"):
            continue
        key, val = line.split(", ")
        if key == "year":
            year = val.strip()
            continue
        # Month will precede year and all other bills
        if key == "month":
            month = int(val.strip())
            break
        # val.trim()
        results[key] = val.strip()
    return month, year, results


class monthly_results(object):
    month = 0
    year = 0
    results = {}
    monthlyTotal = 0
    bills_in_order = {}

    def __init__(self, month, year, results):
        self.month = month
        self.year = year
        self.results = results
        bills = {}
        # Print all bills
        for bill in reversed(list(results.keys())):
            amount = results[bill]
            self.monthlyTotal += (float)(amount)
            bills[bill] = str(amount)
            self.bills_in_order = OrderedDict(sorted(bills.items(),
                                                     key=lambda t: t[0]))
        # always round up by one cent
        self.per_person = (self.monthlyTotal /
                           (float)(NUMBER_OF_ROOMMATES)) + 0.01

    def print_last_months_bills(self):
        print("SUBJECT:\n%s/%s Rent and Utilities\n\n" %
              (calendar.month_abbr[self.month - 1],
               calendar.month_abbr[self.month]))
        print("Hey all,\n")
        print("Here are the bills for this month:")
        print("\n```\n")
        print("%s/%s %s".center(WIDTH) %
              (calendar.month_abbr[self.month - 1],
               calendar.month_abbr[self.month], self.year))
        print('-' + '-' * WIDTH + '-')
        print("| %-18s | %6s |" % ("Utility", "Amount"))
        print('|' + '-' * WIDTH + '|')
        [print("| %-18s | %6s |" %
               (bill, self.bills_in_order[bill]))
         for bill in self.bills_in_order]
        print('-' + '-' * WIDTH + '-')
        print("\n```\n")
        print("**Monthly total: %.2f**" % self.monthlyTotal)
        # always round up by one cent
        print("**Per person: %.2f **" % self.per_person)
        print()
        print("Thanks,\nLuke")

    def print_CSV_for_records(self):
        # Print bills for records
        print()
        print('-' * WIDTH)
        print("\nfor our records:\n")
        print("month,", self.month)
        print("year,", self.year)
        [print(bill + ",",
               self.bills_in_order[bill])
         for bill in self.bills_in_order]
        print("")
        print("total, %.2f" % self.monthlyTotal)
        print("each, %.2f" % self.per_person)


def main():
    print("Calculating bills...\n\n")
    (month, year, results) = read_CSV_info()
    results = monthly_results(month, year, results)
    results.print_last_months_bills()
    results.print_CSV_for_records()


def readlines_reverse(filename):
    with open(filename) as qfile:
        qfile.seek(0, os.SEEK_END)
        position = qfile.tell()
        line = ''
        while position >= 0:
            qfile.seek(position)
            next_char = qfile.read(1)
            if next_char == "\n":
                yield line[::-1]
                line = ''
            else:
                line += next_char
            position -= 1
        yield line[::-1]


if __name__ == "__main__":
    main()
