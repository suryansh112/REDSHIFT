import boto3
import os

def lambda_handler(event, context):

    client = boto3.client('redshift')

    
    cluster_identifier = os.environ.get('cluster_name')

    try:
        
        response = client.pause_cluster(
            ClusterIdentifier=cluster_identifier
        )
        return {
            'statusCode': 200,
            'body': f'Cluster {cluster_identifier} is being paused. Response: {response}'
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': f'Error pausing cluster {cluster_identifier}: {str(e)}'
        }