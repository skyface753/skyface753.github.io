---
layout: post
title: Create a Python pip package
date: 2025-03-28 07:10:00
categories: [Python, Packaging, Pip]
---

This post describes how to create a Python pip package. The instructions are based on the [Python Packaging User Guide](https://packaging.python.org/en/latest/tutorials/packaging-projects/) and the [Python documentation](https://docs.python.org/3/tutorial/modules.html).

## Folder structure

The folder structure of the package should look like this:

```
the_folder/
|-- my_package_YOUR_NAME/
|   |-- __init__.py
|   |-- module1.py
|   |-- module2.py
|   |-- cli/
|       |-- __init__.py
|       |-- module1_cli.py
|       |-- module2_cli.py
|-- utils/
|   |-- __init__.py
|   |-- utils.py
|-- pyproject.toml
|-- requirements.txt
|-- README.md
|-- LICENSE
```

### Files

- `my_package_YOUR_NAME/`: This folder contains the main package code.
- `my_package_YOUR_NAME/__init__.py`: This file is required to make Python treat the directory as a package. (It can be empty.)
- `my_package_YOUR_NAME/module1.py`: This file contains the code for module 1.
- `my_package_YOUR_NAME/module2.py`: This file contains the code for module 2.
- `my_package_YOUR_NAME/cli/`: This folder contains the command line interface (CLI) code.
- `my_package_YOUR_NAME/cli/__init__.py`: This file is required to make Python treat the directory as a package. (It can be empty.)
- `my_package_YOUR_NAME/cli/module1_cli.py`: This file contains the CLI code for module 1.
- `my_package_YOUR_NAME/cli/module2_cli.py`: This file contains the CLI code for module 2.
- `utils/`: This folder contains utility functions.
- `utils/__init__.py`: This file is required to make Python treat the directory as a package. (It can be empty.)
- `utils/utils.py`: This file contains utility functions.
- `pyproject.toml`: This file contains the package metadata and dependencies.
- `requirements.txt`: This file contains the package dependencies.
- `README.md`: This file contains the package description and usage instructions.
- `LICENSE`: This file contains the license information for the package.
- `CHANGELOG.md`: This file contains the changelog for the package.

## Create the package

To create the package, you need to create a `pyproject.toml` file in the root directory of your package. This file contains the package metadata and dependencies.

### Example `pyproject.toml`

```toml
[build-system]
requires = ["setuptools", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "my_package_YOUR_NAME"
version = "0.1.0"
description = "A sample Python package"
readme = "README.md"
authors = [{ name = "Sebastian Jörz", email = "seppel8426@gmail.com" }]
license = { file = "LICENSE" }
dynamic = ["dependencies"]

[tool.setuptools.dynamic]
dependencies = {file = ["requirements.txt"]}

[tool.setuptools]
packages = ["my_package_YOUR_NAME", "utils"]


[project.scripts]
my_package_YOUR_NAME-module1 = "my_package_YOUR_NAME.cli.module1_cli:main"
my_package_YOUR_NAME-module2 = "my_package_YOUR_NAME.cli.module2_cli:main"
```

### Example `requirements.txt`

```
numpy
pandas
```

### Example `my_package_YOUR_NAME/module1.py`

```python
def hello_world(name: str) -> str:
    print(f"Hello, {name}!")
```

### Example `my_package_YOUR_NAME/cli/module1_cli.py`

```python
import argparse
from my_package_YOUR_NAME.module1 import hello_world

def main():
    parser = argparse.ArgumentParser(description="Hello World CLI")
    parser.add_argument("name", type=str, help="Name to greet")
    args = parser.parse_args()
    hello_world(args.name)

if __name__ == "__main__":
    main()
```

## Install the package

To install the package, navigate to the root directory of your package and run the following command:

```bash
pip install .
```

Or, if you want to install it in editable mode (so that changes to the code are immediately reflected), run:

```bash
pip install -e .
```

This will install the package and make it available for use.

## Usage

To use the package, you can import it in your Python code:

```python
from my_package_YOUR_NAME.module1 import hello_world
hello_world("World")
```

Or, you can use the command line interface (CLI) by running the following command:

```bash
my_package_YOUR_NAME-module1 <name>
```

This will print "Hello, <name>!" to the console.

## Publish the package

To publish the package to PyPI, you need to create an account on [PyPI](https://pypi.org/).

Then, you can use the following command to publish the package:

### Build the package

```bash
pip install --upgrade build
python -m build
```

### Upload the package

```bash
pip install --upgrade twine
twine upload dist/*
```

### Install your package

```bash
pip install my_package_YOUR_NAME
```

## Example Project

A example from my own project is available on GitHub. It contains a Python package that generates synthetic data for the detection of microorganisms. The package includes a command line interface (CLI) for easy usage and can be installed via pip. The code can be found on [GitHub](https://github.com/skyface753/synthetic_data_generation).
