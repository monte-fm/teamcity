#!/bin/bash

#Starting SSH and MySQL services
service ssh start
service mysql start

#Starting TeamCity Server
service teamcity start
