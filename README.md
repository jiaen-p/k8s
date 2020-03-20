# k8s
### Complex fibbonacci index calculator

This project runs on containers using docker and it is deployed google cloud, it is engineered to be continuous integration and continuous delivery using github and travis ci to integrate and deploy automatically to gcloud.
It is composed from the following stack:
- **Postgres:** it uses the official docker hub image, however it is configured to use a persistent volume claim, so there's persistency.
- **Redis:** althou it is not necessary for this project to use a cache, it is however used to cache the input data from the front end and sending it to the worker. We use the official docker hub image.
- **NGINX:** it is used to serve the static files from react built and optimized files. 
- **Docker hub**: custom images built and pushed from Travis-ci after passing some tests.

