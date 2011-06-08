#!/bin/bash
./readmegen.pl > README.md.working
sed '1,21d' README.md.working > README.md
