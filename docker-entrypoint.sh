#!/bin/bash
pip install virtualenv
virtualenv GREENDAY
source ./GREENDAY/bin/activate
pip install -r requirements.txt
pip install zc.recipe.egg==2.0.3
buildout
./syncdb.sh
./serve.sh
