# Overview

When migrating product data from Magento 1 to Magento 2 there are a number of steps that need to be taken to sanitize it. The Magento 2 import tool validates the csv file before importing / updating product data. The output can help to determine what needs to be done to sanitize the data.

Steps encountered to sanitize product data are as follows:

- Include required columns
- Rename columns where needed
- Update store names
- Update url keys to be unique

This script is concerned with making duplicate column values unique and aims to automate what would otherwise be a tedious manual process.

# Prerequisites

Ruby can be installed on Ubuntu like so:

```
sudo apt update
sudo apt-install ruby
```

# Description

Given a list of values in a csv column:

```
product-url-one
product-url-two
product-url-three
product-url-three
product-url-three
product-url-four
```

Process the file such that we achieve the following result:

```
product-url-one
product-url-two
product-url-three-1
product-url-three-2
...
product-url-three-n
product-url-four
```

# Usage

`ruby make-unique <file_name.csv> <column_name>`
