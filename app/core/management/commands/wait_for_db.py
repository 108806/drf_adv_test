import time 

from django.db import connections
from django.db import OperationalError
from django.core.management import BaseCommand

class Command(BaseCommand):
    """ Django command to pause exec until db is available"""
    
    def handle(self, *args, **options):
        self.stdout.write('[*] Waiting for db to be available...')
        db_conn = None
        while not db_conn:
            try: 
                db_conn = connections['default']
            except OperationalError:
                self.stdout.write('[*] No connection available, waiting 1 second.')
                time.sleep(1)
        
        self.stdout.write(self.style.SUCCESS('Database available!')) 

