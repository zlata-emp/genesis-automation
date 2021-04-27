## genesis-automation

### Setup
##### chrome
Configure policies for chrome browser to use links, which needs two way client authentication certificates.

```
sudo mkdir /etc/opt/chrome/policies/managed/
sudo nano /etc/opt/chrome/policies/managed/test_policy.json
```
The content of _test_policy.json_ should look like:
```
{
  "AutoSelectCertificateForUrls": [
    "{\"pattern\":\"https://staging.admin.emerchantpay.net\",\"filter\":{\"SUBJECT\":{\"CN\":\"STG PSP - Your Name\"}}}",
    "{\"pattern\":\"https://staging.admin.e-comprocessing.net\",\"filter\":{\"SUBJECT\":{\"CN\":\"STG BANK - Your Name\"}}}",
    "{\"pattern\":\"https://sof-dev.admin.emerchantpay.local\",\"filter\":{\"SUBJECT\":{\"CN\":\"SOF-DEV PSP - Your Name\"}}}",
    "{\"pattern\":\"https://admin.emp-gateway.local\",\"filter\":{\"SUBJECT\":{\"CN\":\"PROD PSP - Your Name\"}}}",
    "{\"pattern\":\"https://admin.ecp-gateway.local\",\"filter\":{\"SUBJECT\":{\"CN\":\"PROD BANK - Your Name\"}}}"
  ]
}
``` 
For exact names go to `chrome://settings/certificates?search=cert` -> Manage certificates and fill for `CN` the **Common Name (CN)** of the certificates. (Example: `STG PSP - Your Name` should be `STG PSP - Jane Doe`)

If you use Cromium browser (or some other alternative to Chrome like Brave browser) copy the policies 

```
sudo mkdir /etc/chromium/policies/managed/
sudo cp /etc/opt/chrome/policies/managed/test_policy.json /etc/chromium/policies/managed/
```

</br>
</br>
</br>

### Usage 

The project uses features from rspec. Filtering tests is done by specifying **tags**.

To run this specific tests tagged with **:smoke** for example, you would specify `--tag` or `-t` and the tag name (without the :) as a runtime parameter, like so:

```
rspec --tag smoke
```
which will run only the smoke tests (with tags :smoke).

You can also tag each individual test and specify multiple tags at run time:
```
rspec --tag smoke -t ui
```
which will run all tests tagged with `:smoke` and `:ui`.

Alternatively, you can ignore tags with a `~` prepended to the tag name:
```
rspec --tag ~smoke -t ui
```
this will run all `:ui` tests excluding the ones tagged with `:smoke`.

See http://elementalselenium.com/tips/58-tagging for how to use rspec tagging


By default `./config/local.rb` is loaded to add Environment variables to be used during the tests. (Example: `BASE_URL = 'http://127.0.0.1'`)
If you need to run tests for other env just specify the file to be required by rspec:
```
rspec -r "./config/staging_psp.rb" -t ui
```
will start all test tagged with `:ui` for the staging env.