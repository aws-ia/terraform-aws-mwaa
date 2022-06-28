from airflow import DAG
from datetime import datetime, timedelta
from airflow.utils.dates import days_ago
from airflow.operators.bash_operator import BashOperator

import copy
import os

default_args = {
    'owner': 'airflow',
    'depends_on_past': False,
    'email': ['ricsue@amazon.com'],
    'email_on_failure': False,
    'email_on_retry': False
    # 'queue': 'bash_queue',
    # 'pool': 'backfill',
    # 'priority_weight': 10,
    # 'end_date': datetime(2016, 1, 1),
    # 'wait_for_downstream': False,
    # 'sla': timedelta(hours=2),
    # 'execution_timeout': timedelta(seconds=300),
    # 'on_failure_callback': some_function,
    # 'on_success_callback': some_other_function,
    # 'on_retry_callback': another_function,
    # 'sla_miss_callback': yet_another_function,
    # 'trigger_rule': 'all_success'
}

DAG_ID = "hello_world_scheduled_dag"

dag = DAG(
    dag_id=DAG_ID,
    default_args=default_args,
    description='Scheduled Apache Airflow DAG',
    schedule_interval='* 1 * * *',
    start_date=days_ago(1),
    tags=['aws','demo'],
)


say_hello = BashOperator(
        task_id='say_hello',
        bash_command="echo hello" ,
        dag=dag
    )

say_goodbye = BashOperator(
        task_id='say_goodbye',
        bash_command="echo goodbye",
        dag=dag
    )

say_hello >> say_goodbye