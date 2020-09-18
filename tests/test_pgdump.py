import pytest
import subprocess

from pgbackup import pgdump

url="postgres://bob:password@example.com:5432/db_one"

def test_dump_calls_pg_dump(mocker):
    """
    Utilize pg_dump with the database URL
    """
    mocker.patch('subprocess.Popen')
    assert pgdump.dump(url)
    subprocess.Popen.assert_called_with(['pg_dump', url], stdout=subprocess.PIPE)
#

def test_dump_handles_oserror(mocker):
    """
    pgdump.dump returns a reasonable error if pg_dump isn't installed
    """
    mocker.patch('subprocess.Popen', side_effect=OSError('No SUch File or Directory'))
    with pytest.raises(SystemExit):
        pgdump.dump(url)
    #
#

def test_dump_file_without_timestamp():
    """
    pgdump.dump_file_name returns the name of the database without time stamp
    """
    assert pgdump.dump_file_name(url) == "db_one.sql"
#

def test_dump_file_with_timestamp():
    """
    pgdump.dump_file_name returns the name of the database with time stamp
    """
    timestamp = "2017-12-03T13:14:10"
    assert pgdump.dump_file_name(url, timestamp) == f"db_one-{timestamp}.sql"
#
