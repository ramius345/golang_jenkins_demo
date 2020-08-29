# nexus-chart

Prereqs:

helm 3+

Install instructions (from the directory above this checkout):

```bash
oc new-project nexus-demo
helm install --name-template nexus-demo nexus-chart
oc logs -n nexus-demo -f $(oc get pods | grep -v deploy | grep -v NAME | awk '{print $1}')
```

Wait for the line:
Started Sonatype Nexus OSS 3.21.1-01


Then hit the route:

```bash
oc get route nexus -n nexus-demo
```

Paste the route into your browser.  It will be using your router's wildcard certificate (accept any errors if its self signed).
