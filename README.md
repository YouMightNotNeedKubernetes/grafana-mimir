# Grafana Mimir
A high-availability Grafana Mimir deployment for Docker Swarm

## Getting Started

You might need to create swarm-scoped overlay network called `dockerswarm_monitoring` for all the stacks to communicate if you haven't already.

```sh
$ docker network create --driver overlay --attachable dockerswarm_monitoring
```

We provided a base configuration file for Grafana Mimir. You can find it in the `config` folder.  
Please make a copy as `configs/mimir.yaml`, make sure to change the following values:

```yml
common:
  storage:
    backend: s3
    s3:
      endpoint: minio:9000
      region: us-east-1
      bucket_name: mimir
      access_key_id: access_key_id
      secret_access_key: secret_access_key
      insecure: true

alertmanager:
  external_url: http://alertmanager:9093/alertmanager
```

And add any additional configuration you need to `configs/mimir.yaml`.

### Object Storage buckets

You need to create the following buckets in your object storage:
- `mimir`
- `mimir-blocks`
- `mimir-ruler`
- `mimir-alertmanager`

You can change the bucket names in the `configs/mimir.yaml` file. Look for the `bucket_name` property.

**Example**
```yaml
blocks_storage:
  s3:
    bucket_name: mimir-blocks # Change this to your bucket name
```

## Deployment

To deploy the stack, run the following command:

```sh
$ make deploy
```

## Destroy

To destroy the stack, run the following command:

```sh
$ make destroy
```
