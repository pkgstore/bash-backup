# Backup Scripts

Scripts for backup files and MySQL databases.

## Files

backup.files.sh

#### Parameters

- `-d 'DIR_1;DIR_2;DIR_3'`  
  Directories.

#### Syntax

```sh
./backup.files.sh -d '/home/dir_1;/home/dir_2;/home/dir_3'
```

- Backup directories `dir_1`, `dir_2` and `dir_3`.

## MySQL Databases

backup.mysql.sh

#### Parameters

- `-u 'USER'`  
  MySQL user name.
- `-p 'PASSWORD'`  
  MySQL user password.
- `-d 'DB_1;DB_2;DB_3'`  
  MySQL databases.

#### Syntax

```sh
./backup.mysql.sh -u 'db_user' -p 'db_password' -d 'db_name_1;db_name_2;db_name_3'
```

- Backup databases `db_name_1`, `db_name_2` and `db_name_3` with username `db_user` and password `db_password`.
