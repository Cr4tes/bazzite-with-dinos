#!/bin/bash

set -ouex pipefail

echo "# Custom Variables" >> /etc/environment
echo "GSK_RENDERER=ngl" >> /etc/environment
