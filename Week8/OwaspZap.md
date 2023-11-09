## OWASP ZAP

ZAP, formerly known as OWASP ZAP (Zed Attack Proxy), is an open-source web application security scanner. It is intended to be used by both those new to application security as well as professional penetration testers.

ZAP comes as a desktop app as well as a Docker container that can be used to automate security tests in the CI/CD pipeline

### Install ZAP Desktop

ZAP desktop can be [downloaded from here](https://www.zaproxy.org/download). Once downloaded and installed, specify the website to carry out DAST and click the `Attack` button to run tests on the site.
> Note: Only carry out DAST tests on sites you are authorized to attack as they may cause disruptions.


### Add ZAP Testing in CI/CD Pipeline

ZAP testing can easily be included in the CI/CD pipeline by running a Docker command in headless mode to execute baseline or full tests:

#### Baseline test
```bash
docker run -v $(pwd):/home/zap:rw  -t ghcr.io/zaproxy/zaproxy:stable zap-baseline.py -t https://site-to-test.com 
```

There are also github actions provided for integration into github pipeline. To implement a github action for ZAP full test, below is a sample github workflow file:

```yaml
on: [push]

jobs:
  zap_scan:
    runs-on: ubuntu-latest
    name: Scan the webapplication
    steps:
      - name: Checkout
        uses: actions/checkout@v2
        with:
          ref: master
      - name: ZAP Scan
        uses: zaproxy/action-full-scan@v0.8.0
        with:
          token: ${{ secrets.GITHUB_TOKEN }}
          docker_name: 'ghcr.io/zaproxy/zaproxy:stable'
          target: 'https://site-to-test.com/'
          rules_file_name: '.zap/rules.tsv'
          cmd_options: '-a'
```

Note that the secrets.GITHUB_TOKEN