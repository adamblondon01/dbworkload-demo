import datetime as dt
import psycopg
import random
import time
import uuid


class Ulta_beauty:
    def __init__(self, args: dict):
        # args is a dict of string passed with the --args flag
        # user passed a yaml/json, in python that's a dict object

        # self.read_pct: float = float(args.get("read_pct", 50) / 100)

        # you can arbitrarely add any variables you want
        self.cust_id: uuid.UUID = uuid.uuid4()

    # the setup() function is executed only once
    # when a new executing thread is started.
    # Also, the function is a vector to receive the excuting threads's unique id and the total thread count
    def setup(self, conn: psycopg.Connection, id: int, total_thread_count: int):
        with conn.cursor() as cur:
            print(
                f"My thread ID is {id}. The total count of threads is {total_thread_count}"
            )
            print(cur.execute(f"select version()").fetchone()[0])

    # the run() function returns a list of functions
    # that dbworkload will execute, sequentially.
    # Once every func has been executed, run() is re-evaluated.
    # This process continues until dbworkload exits.
    def loop(self):
        return [self.txn1, self.txn2]


    def txn1(self, conn: psycopg.Connection):
        # find the customer id

        # make sure you pass the arguments in this fashion
        # so the statement can be PREPAREd (extended protocol).

        # Simple SQL strings will use the Simple Protocol.
        with conn.cursor() as cur:

            secondary_cust_id=random.randint(1,30000000)

            stmt = """
                select cust_id from customers where secondary_cust_id=%s;
                """
            cur.execute(stmt, (secondary_cust_id,))

            self.cust_id=cur.fetchone()[0]

    def txn2(self, conn: psycopg.Connection):
        # update loyalty account for the customer based on their purchase
        with conn.cursor() as cur:

            today = str(dt.datetime.now())[0:10]

            new_pts=random.randint(1,500)

            stmt = """
                    update loyalty set total_points=total_points+%s, total_points_this_year=total_points_this_year+%s,total_transactions=total_transactions+1,total_transactions_this_year=total_transactions_this_year+1,last_purchase_date=%s where cust_id=%s;
                    """
            cur.execute(stmt, (new_pts,new_pts,today,self.cust_id))
