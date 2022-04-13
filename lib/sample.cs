//
            // Get authorization server url
            // ============================
            var oauthServerUrl = GetOAuthServerUrl(innovatorServerDiscoveryUrl);

            if (oauthServerUrl == null)
                Environment.Exit(0);

            //
            // Get token endpoint
            // ==================
            var oauthServerConfigurationUrl = oauthServerUrl + ".well-known/openid-configuration";

            var tokenUrl = GetTokenEndpoint( oauthServerConfigurationUrl );

            if (tokenUrl == null)
                Environment.Exit(0);


                static string GetTokenEndpoint(string url)
        {
            var configuration = GetJson(url);

            return configuration?.token_endpoint;
        }


// Sample get parts
string accessToken = tokenData.access_token;
            string odataUrl = innovatorUrl + "/server/odata/Part";

            var parts = GetJson(odataUrl, accessToken);