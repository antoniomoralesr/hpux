#!/bin/ksh
#=============================================================#
# antonio.moralesr@gmail.com                                  #
# Este script se distribuye bajo licencia GPL                 #
# 2011/03/23                                                  #
# v1. Script para obtener la configuración de los paquetes    #
# y del cluster SG                                            #
#=============================================================#

FECHA=`date +%Y%m%d`

FLAG=0

for PACKAGE in $(cmviewcl -f line |grep name | grep -v node | awk '{ FS="="; print $2}'); do
        case "${FLAG}" in
        0)
                cmgetconf -c ${PACKAGE} CL-${PACKAGE}.${FECHA}.ascii
                FLAG=1
        ;;
        1)
                cmgetconf -p ${PACKAGE} PKG-${PACKAGE}.${FECHA}.ascii
        ;;
        esac
done

tar -cvf ${FECHA}_ConfClus.tar *.ascii
gzip ${FECHA}_ConfClus.tar
