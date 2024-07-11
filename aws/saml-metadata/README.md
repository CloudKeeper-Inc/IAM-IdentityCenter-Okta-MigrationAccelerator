# SAML Metadata File

This directory is designated for storing the SAML metadata file for the Identity Provider (IDP). The file will be placed here automatically by the program.

## SAML Metadata File

The SAML metadata file contains the necessary configuration information for the IDP, including the entity ID, assertion consumer service URLs, and certificates.

## Automatic Placement

The SAML metadata file will be automatically placed in this directory by the program. No manual intervention is required.

## Example SAML Metadata File

Below is an example of what a SAML metadata file might look like:

```xml
<EntityDescriptor entityID="https://example-idp.com/metadata" xmlns="urn:oasis:names:tc:SAML:2.0:metadata">
    <IDPSSODescriptor protocolSupportEnumeration="urn:oasis:names:tc:SAML:2.0:protocol">
        <KeyDescriptor use="signing">
            <KeyInfo xmlns="http://www.w3.org/2000/09/xmldsig#">
                <X509Data>
                    <X509Certificate>MIID...</X509Certificate>
                </X509Data>
            </KeyInfo>
        </KeyDescriptor>
        <SingleSignOnService Binding="urn:oasis:names:tc:SAML:2.0:bindings:HTTP-Redirect" Location="https://example-idp.com/sso"/>
    </IDPSSODescriptor>
</EntityDescriptor>
