This is an RSpec project to automate user interaction with api service and web project. 

</br>

### Goal
To automate this test plan:
https://docs.google.com/spreadsheets/d/1g1LNgt0YJcgP7wFXbpv8TGb2eaQxmKLkmjVUFsYI-JY/edit#gid=541028001


### Usage 

The project uses features from rspec. Filtering tests is done by specifying [tags](https://relishapp.com/rspec/rspec-core/v/3-3/docs/command-line/tag-option), [pattern](https://relishapp.com/rspec/rspec-core/v/3-3/docs/command-line/pattern-option) or [example](https://relishapp.com/rspec/rspec-core/v/3-3/docs/command-line/example-option) command-line options.

To run this specific tests tagged with **:ui** for example, you would specify `--tag` or `-t` and the tag name (without the :) as a runtime parameter, like so:

```
rspec --tag ui
```
which will run only the ui tests (with tags :ui).

Filtering tests by tags with values like `processing: :bogus` use:
```
rspec -t processing:bogus
```

You can also tag each individual test and specify multiple tags at run time:
```
rspec --tag ui -t mail
```
which will run all tests tagged with `:ui` and `:mail`.

Alternatively, you can ignore tags with a `~` prepended to the tag name:
```
rspec --tag ~mail -t ui
```
this will run all `:ui` tests excluding the ones tagged with `:mail`.

See http://elementalselenium.com/tips/58-tagging for how to use rspec tagging


</br>
</br>
</br>

### Configuration
##### Environment 

By default `./config/local.rb` is loaded to add Environment variables to be used during the tests.
If you need to run tests for other env just specify the file to be required by rspec:
```
rspec -r "./config/staging_psp.rb" -t ui
#or ommit the file extension .rb
rspec -r "./config/staging_psp" -t ui
```
will start all test tagged with `:ui` for the staging psp env.

##### Config files

For every environment there should be a config file in `config` dir.
These files are regular ruby classes named `Environment`, which contain constants like `PROCESSING`, `MAIL`, `WPF` etc.
The constants are used to store information for the particular component. For example `MAIL` constant will hold the infor of the email address on which you may revieve lost password recovery mails.
**Note!**: If the constant is not defined, this will automatically exclude all rspecs tagged for this component. (Example: if `MAIL` is not defined or just commented out - this will be equivalent to running rspec with `-t mail`, which means all tests tagged with :mail will be excluded).



##### Chrome browser
For `UI` tests, selenium is used to control Chrome browser. The web project tested here uses two way client authentication. 
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
