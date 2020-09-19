import pytest
from hr import cli
@pytest.fixture()
def parser():
    return cli.create_parser()
#
def test_parser_fails_without_arguments(parser):
    """
    Without a path, the parser should exit with an error.
    """
    with pytest.raises(SystemExit):
        parser.parse_args([])
    #
#
