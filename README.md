# TP Controle d'acces Oracle


## Installation

``` docker build -t wnameless/oracle-xe-11g . ```

``` docker run -d -p 49161:1521 -e ORACLE_ALLOW_REMOTE=true wnameless/oracle-xe-11g-r2 ```

Accès à la base depuis SqlDeveloper avec les paramètres suivants :

```
hostname: localhost
port: 49161
sid: xe
username: system
password: oracle
```
