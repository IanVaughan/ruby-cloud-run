# Intro

* https://medium.com/google-cloud/ruby-functions-on-cloud-run-db6ea95ad8ac
* https://googlecloudplatform.github.io/functions-framework-ruby/v1.0.1/file.deploying-functions.html

## Local

```bash
bundle exec functions-framework-ruby --source=app.rb --target hello
I, [2021-10-19T22:23:22.278815 #83940]  INFO -- : FunctionsFramework v0.11.0
I, [2021-10-19T22:23:22.278909 #83940]  INFO -- : FunctionsFramework: Loading functions from "./app.rb"...
I, [2021-10-19T22:23:22.279320 #83940]  INFO -- : FunctionsFramework: Looking for function name "hello"...
I, [2021-10-19T22:23:22.279357 #83940]  INFO -- : FunctionsFramework: Starting server...
I, [2021-10-19T22:23:22.360042 #83940]  INFO -- : FunctionsFramework: Serving function "hello" on port 8080...
I, [2021-10-19T22:24:04.571985 #83940]  INFO -- : FunctionsFramework: Handling HTTP GET request
```

In another terminal:

```bash
$ curl localhost:8080
Hello, world!
```

## Docker

```bash
docker build --tag ruby-cloud-run-hello .
# docker run --rm -it -p 8080:8080 ruby-cloud-run-hello --source=app.rb --target=hello
docker run --rm -it -p 8080:8080 ruby-cloud-run-hello
```

## Deploy

```bash
# Set env var "GCP_PROJECT" to our project name
GCP_PROJECT=$(gcloud config list --format 'value(core.project)' 2>/dev/null)
# Build and upload your image in Google Container Registry
gcloud builds submit --tag gcr.io/$GCP_PROJECT/helloruby
```

```bash
# Deploy your container to Cloud Run
gcloud run deploy helloruby --image gcr.io/$GCP_PROJECT/helloruby \
  --platform managed \
  --allow-unauthenticated
```

```bash
gcloud functions deploy helloruby \
    --project=ruby-cloud-run \
    --runtime=ruby27 \
    --trigger-http \
    # --entry-point=$YOUR_FUNCTION_TARGET


Deploying function (may take a while - up to 2 minutes)...⠛
For Cloud Build Logs, visit: https://console.cloud.google.com/cloud-build/builds;region=us-central1/ad823041-b0f4-4c40-be27-883e372ef8a2?project=1060745777113
Deploying function (may take a while - up to 2 minutes)...done.
availableMemoryMb: 256
buildId: c2411b91-ab07-4a85-ae9a-98f92bc91035
buildName: projects/1060745777113/locations/us-central1/builds/c2411b91-ab07-4a85-ae9a-98f92bc91035
entryPoint: helloruby
httpsTrigger:
  securityLevel: SECURE_OPTIONAL
  url: https://us-central1-ruby-cloud-run.cloudfunctions.net/helloruby
ingressSettings: ALLOW_ALL
labels:
  deployment-tool: cli-gcloud
name: projects/ruby-cloud-run/locations/us-central1/functions/helloruby
runtime: ruby27
serviceAccountEmail: ruby-cloud-run@appspot.gserviceaccount.com
sourceUploadUrl: https://storage.googleapis.com/gcf-upload-us-central1-64aefba9-3920-4711-ad42-22115f076841/6fb5f2cf-058a-42bf-aecd-eb0254250719.zip
status: ACTIVE
timeout: 60s
updateTime: '2021-10-19T22:21:25.485Z'
versionId: '3'
```

```
curl https://us-central1-ruby-cloud-run.cloudfunctions.net/helloruby
Hello, world!
```
