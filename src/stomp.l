%{
 /* Tokenizer for the STOMP 1.2 protocol. */
%}

%%
 /* Client commands. */
"SEND"                          return T_CLIENT_SEND;
"SUBSCRIBE"                     return T_CLIENT_SUBSCRIBE;
"UNSUBSCRIBE"                   return T_CLIENT_UNSUBSCRIBE;
"BEGIN"                         return T_CLIENT_BEGIN;
"COMMIT"                        return T_CLIENT_COMMIT;
"ABORT"                         return T_CLIENT_ABORT;
"ACK"                           return T_CLIENT_ACK;
"NACK"                          return T_CLIENT_NACK;
"DISCONNECT"                    return T_CLIENT_DISCONNECT;
"CONNECT"                       return T_CLIENT_CONNECT;
"STOMP"                         return T_CLIENT_STOMP;

 /* Server Commands. */
"CONNECTED"                     return T_SERVER_CONNECTED;
"MESSAGE"                       return T_SERVER_MESSAGE;
"RECEIPT"                       return T_SERVER_RECEIPT;
"ERROR"                         return T_SERVER_ERROR;

 /* Other tokens */
\x00                            return T_NULL;
\x0A                            return T_LF;
\x0D                            return T_CR;
[\x0D]?\x0A                     return T_EOL;
:                               return T_COLON;
[0-255]                         return T_OCTET;
 /* (T_OCTET - (T_LF + T_CR + T_COLON)) */
[\x00-\x09\x0B-\x0C\x0E-\xFF]   return T_SPECIAL;

%%
