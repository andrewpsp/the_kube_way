# Cloud Admin Node

- Nodes that allow access to cloud API and CLI resources when deployed. 
- Default Keys and tokens passed to the containers as secrets as volumes, files, enviroment varibles or keys. 


###### Key takeaways :

* Secrets mounted on Volumes as Persistent Storage 
* Projection of secret keys to specific paths


When below is deployed will have api and cli access to AWS, Azure, Openstack, GCE platforms
```
---
apiVersion: 3 
kind: Pod
metadata: 
  name: Hello-API 
spec : 
    contianers: 
     - name: Hello-API
       image: 094058724750.dkr.ecr.us-west-2.amazonaws.com/hello-api:latest
 #multiple locations where our isolated secrets will be deployped to
       volumeMounts: 
         - name: Hello-Amazon 
           mountPath: opt/.aws
           read only: true  
         - name: Hello-Google
           mountPath: /opt/.gce
           read only: true
         - name: hHello-Openstack
           mountPath: /opt/.openstack
           read only: true
         - name: Hello-Microsoft
           mountPath: /opt/.azure
           read only: true
#External location of isolated secrets to be mounted in the deployed enviroment.
#Projection of secret keys to specific paths
    volumes:
      - name: Hello-Amazon
        secret: 
          secretName: credentials 
          items:
            - key: access_id
              path: credentials/access_id   
            - key:  secret_key
              path: credentials/access_id
      - name: Hello-Google
        secret: 
          secretName: GSUtil 
          items:
            - key: client_id
              path: boto/client_id  
            - key:  secret_key
              path: boto/client_secret
      - name: Hello-Openstack
        secret: 
          secretName: keystone-rc
          items:
            - key: OS_USERNAME
              path: keystonerc/os_username  
            - key: OS_PASSWORD
              path: keystonerc/os_password 
      - name: Hello-Microsoft
        secret:
          secretName: config
          items:
            - key: azure_id
              path: config/azure_id   
            - key: azure_key
              path: config/azure_key
    restartPolicy: never


```
## Solving the Challange: 

* pass other sensitive data in our application instances without incuding in the source file





## The second use case :
* Consuming Secret Values from Environment Variables

When below is deployed will have api and cli access to AWS and GCE platforms

```
apiVersion: v1
kind: Pod
metadata:
  name: Hello-APIv2
spec:
  containers:
  - name: Hello-APIv2
    image: 094058724750.dkr.ecr.us-west-2.amazonaws.com/hello-api:latest
    env:
      - name: cloud-admin-node
        valueFrom:
          secretKeyRef:
            name: credentials
            key: access_id
      - name: cloud-admin-node
        valueFrom:
          secretKeyRef:
            name: GSUtil
            key: client_id
  restartPolicy: Never
```



## Getting Started

To begin using this template, choose one of the following options to get started:
* [Download the latest release on entercloud.info/builds](http://entercloud.info:8080)
* Clone the repo: `git clone https://github.com/andrewpsp/the_kube_way.git`
* secrets created using`$kubectl create secret generic cloud-admin-node --from-file=./yourfiles.txt --from-file=./yourfiles.json`



## Bugs and Issues

Have a bug or an issue with this template? [Open a new issue](https://github.com/andrewpsp/the_kube_way/issues) here on GitHub or leave a comment on the [Twitter](http://twitter.com/andrewpsp).

## Creator
The Kube Way was created by and is maintained by [Andrew S Thompson]

* https://twitter.com/andrewpsp


[logo]: https://github.com/andrewpsp/the_kube_way/blob/master/art.jpg "Key functions"

