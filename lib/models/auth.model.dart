import 'dart:convert';

class AuthModel {
  String accessToken = "";
  int expiresIn = 0;
  String tokenType = "";
  String scope = "";
  AuthModel({
    required this.accessToken,
    required this.expiresIn,
    required this.tokenType,
    required this.scope,
  });
  Map<String, dynamic> example = {
    "access_token":
        "eyJhbGciOiJSUzI1NiIsImtpZCI6IkFCNTEwNDIzRDk5MzVFRjBCNDNCRjk3RTM1RTU3OTRBQkU3Mzg5RDIiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJxMUVFSTltVFh2QzBPX2wtTmVWNVNyNXppZEkifQ.eyJuYmYiOjE2NDkzNDQ0OTMsImV4cCI6MTY0OTM4MDQ5MywiaXNzIjoiT0F1dGhTZXJ2ZXIiLCJhdWQiOlsiT0F1dGhTZXJ2ZXIvcmVzb3VyY2VzIiwiSW5ub3ZhdG9yIl0sImNsaWVudF9pZCI6ImF0aXNocGxheWdyb3VuZCIsInN1YiI6ImFzaGFreWEiLCJhdXRoX3RpbWUiOjE2NDkzNDQ0OTMsImlkcCI6ImxvY2FsIiwidXNlcm5hbWUiOiJhc2hha3lhIiwiZGF0YWJhc2UiOiJ1cGF5c3RhZ2luZzAwMSIsInNjb3BlIjpbIklubm92YXRvciJdLCJhbXIiOlsicGFzc3dvcmQiXX0.aadk2wQdhW1ttDcEqU3sPKAQYZ7s8vB2KL_ewNmPhhZWQ_yOU9FerjFnvdBO0aK7l2T-Rv0jZm_87NgTMi2XyiVUuo5XugspQiyLnep_T6tagSYTdbtLk52N-cFk8nv4VutmnXVEwUlyGzT81zFT3QTPNFKRWchksYUxf_bsFTbEBXbwi6eD0UxTuYCa7k1_qW5Z664pUHC-Z8NzfgIeg92MGQ0wX9-3KbaT-ZW4hRIeKHgwSPchIgtoy9elhzjlFZkWEuKQUBYHabhcCfAyy3FqlZGka3Yo2p2nQWK4KBFWx9xehKxU4tS3aglpb7rZndF3C0HgTSJyq-zB24I-6Q",
    "expires_in": 36000,
    "token_type": "Bearer",
    "scope": "Innovator"
  };

  AuthModel copyWith({
    String? accessToken,
    int? expiresIn,
    String? tokenType,
    String? scope,
  }) {
    return AuthModel(
      accessToken: accessToken ?? this.accessToken,
      expiresIn: expiresIn ?? this.expiresIn,
      tokenType: tokenType ?? this.tokenType,
      scope: scope ?? this.scope,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'access_token': accessToken,
      'expires_in': expiresIn,
      'token_type': tokenType,
      'scope': scope,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      accessToken: map['access_token'] ?? '',
      expiresIn: map['expires_in']?.toInt() ?? 0,
      tokenType: map['token_type'] ?? '',
      scope: map['scope'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) => AuthModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthModel(accessToken: $accessToken, expiresIn: $expiresIn, tokenType: $tokenType, scope: $scope)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthModel &&
        other.accessToken == accessToken &&
        other.expiresIn == expiresIn &&
        other.tokenType == tokenType &&
        other.scope == scope;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^ expiresIn.hashCode ^ tokenType.hashCode ^ scope.hashCode;
  }
}
