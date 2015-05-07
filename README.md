# PHPQA MAkefile

This repository contains a Makefile wich support several tools from http://jenkins-php.org/

Its a alternative for the build.xml file, and provides a much faster running using Makefile parallel jobs.

# Install

```bash
$ composer require rodrigorm/phpqa-make
```

# Usage

You can use directly from command line:

```bash
$ make -f vendor/rodrigorm/phpqa-make/Makefile phpqa-build
```

Or using include from your Makefile, if you want for example setup some variables:

```Makefile
SRCDIR = lib
BIN = bin

include vendor/rodrigorm/phpqa-make/Makefile
```


# Recipes

## Lint

Perform syntax check of sourcecode files

```bash
$ make phpqa-lint
```

## PHPLOC

Measure project size using PHPLOC

```bash
$ make phpqa-phploc
```

## PDepend

Calculate software metrics using PHP_Depend

```bash
$ make phpqa-pdepend
```

## PHPMD

Perform project mess detection using PHPMD creating a log file for the continuous integration server

```bash
$ make phpqa-phpmd
```

## PHPCS

Find coding standard violations using PHP_CodeSniffer and print human readable output. Intended for usage on the command line before committing.

```bash
$ make phpqa-phpcs
```

Find coding standard violations using PHP_CodeSniffer creating a log file for the continuous integration server

```bash
$ make phpqa-phpcs-ci
```

## PHPCPD

Find duplicate code using PHPCPD

```bash
$ make phpqa-phpcpd
```

## PHPUnit

Run unit tests with PHPUnit

```bash
$ make phpqa-phpunit
```

Run unit tests with PHPUnit and generate coverage

```bash
$ make phpqa-phpunit-ci
```

## License

Copyright (C) 2014 Rodrigo Moyle <rodrigorm@gmail.com>

This program is free software: you can redistribute it and/or modify
it under the terms of the Lesser GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the Lesser GNU General Public License
along with this program. If not, see http://www.gnu.org/licenses/.
