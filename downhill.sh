#!/bin/sh

cobc -x -free cow.cbl `ls -d controllers/*` -o the.cow
