resource "aws_iam_saml_provider" "idp" {
  name                   = "Okta-IdP"
  saml_metadata_document = file(var.saml_metadata_document)
}
