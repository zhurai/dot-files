#!/bin/bash

for i in {1..130}; do VBoxManage hostonlyif remove vboxnet$i ; done

