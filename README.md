# dbt sample

## setup

```shell
python3 -m venv venv
source venv/bin/activate
pip install poetry
poetry add dbt-bigquery
dbt --version
dbt init dbt_sample_bigquery
```

`~/.dbt/profiles.yml`

```yaml
dbt_sample_bigquery:
  outputs:
    dev:
      dataset: my_dataset
      job_execution_timeout_seconds: 300
      job_retries: 1
      location: asia-northeast1
      method: oauth
      priority: interactive
      project: my_project
      threads: 1
      type: bigquery
  target: dev
```

## execution

```shell
dbt debug
dbt compile
dbt run
```

## test

```shell
dbt deps
dbt test
```