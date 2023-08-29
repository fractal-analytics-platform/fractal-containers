"""Generates requirements.txt file by querying PyPI.

Usage:
    python gen_requirements <package_name> <destination file>
"""


import sys
import urllib.request
import json
import re

package = sys.argv[1]
outfile = sys.argv[2]

url = "https://pypi.org/pypi/" + package + "/json"
print(f"Querying {url}...")

with urllib.request.urlopen(url) as site:
    res = json.load(site)["info"]["requires_dist"]

with open(outfile, "w", encoding="utf-8") as out:
    for package in res:
        cleaned = re.sub(" ;.*", "", package)

        # adding fix for psycopg2
        cleaned = re.sub(
            "psycopg2 ", "psycopg2-binary ", cleaned
        )

        print(cleaned, file=out)
