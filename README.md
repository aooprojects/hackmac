# ./hackmac
a small shellscript to get the vendor from a MAC adress and convert it into several formats that might be useful for a network engineer


**get the vedor OUI database from IEEE with updateoui.sh first! if you want to get the vendor**

example:
```
$ ./hackmac.sh 00:1b:63:84:45:e6
ormalized MAC: 00-1B-63-84-45-E6
Vendor 00-1B-63
00-1B-63   (hex)                Apple, Inc.
001B63     (base 16)            Apple, Inc.
                                1 Infinite Loop
                                Cupertino  CA  95014
                                US

1) 00-1B-63-84-45-E6
2) 00.1B.63.84.45.E6
3) 00:1B:63:84:45:E6
4) 001b-6384-45e6
5) 001b.6384.45e6
6) 001b:6384:45e6
7) 001B63-8445E6
8) 001B63.8445E6
9) 001B63:8445E6
EUI64 SLAAC IPv6 IP: fe80::21b:63ff:fe84:45e6
```
