#Cloud Admin Node

- Nodes that allow access to cloud API and CLI resources when deployed. 
- Default Keys and tokens passed to the containers as secrets from volumes


###### Key takeaways :

* Secrets mounted on Volumes as Persistent Storage 
* Pods references mount points to expose corret mounted secret 


```
---
apiVersion: 3 
kind: Pod
metadata: 
  name: Hello-API 
spec : 
    contianers: 
     - name: Hello-API
       image: hello-world
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

