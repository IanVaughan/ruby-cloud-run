# Intro

From: https://medium.com/google-cloud/ruby-functions-on-cloud-run-db6ea95ad8ac

```bash
> bundle exec functions-framework --target hello
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

```bash
gcloud components update

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
