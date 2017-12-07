# FASCIA
A graphical dashboard for client metrics

## Establishing a virtualenv and dependencies

**To set up development environment:**
Make sure you have docker running.
This assumes you are using Docker for Mac.

```python
virtualenv env
pip install -r requires/development.txt
source ./bootstrap.sh
```

## Running the server

At any commit, you should be able to run:

```run-fascia```

## Running the tests

```nosetests -sxv```
