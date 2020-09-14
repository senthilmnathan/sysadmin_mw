from argparse import ArgumentParser

class DriverAction(Action):
    def call(self, parser, namespace, values, option_string=None):
        driver, destination = values
        namespace.driver = destination
    #
#

def create_parser():
    parser = ArgumentParser(description="""
    Back up PostgreSQL databases locally or to AWS S3.
    """)
    parser.add_argument("url", help="URL of database to backup")
    parser.add_argument("--driver",
           help="How and Where to backup",
           nargs=2,
           action=DriverAction,
           required=True)
    return parser
#
