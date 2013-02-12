%{
 /* Parser for the STOMP 1.2 protocol. */
 #include <stdio.h>
 #include "../client_protocol_stomp.h"

 extern stomp_node_t stomp_frame_root;

 void yyerror(const char *str) {
     fprintf(stderr,"error: %s\n",str);
 }
 
 int yywrap() {
     return 1;
 }

 int yylex(void);
%}

%defines
%error-verbose

/* Tokens for header file generation. */
%token T_CLIENT_SEND T_CLIENT_SUBSCRIBE T_CLIENT_UNSUBSCRIBE T_CLIENT_BEGIN
%token T_CLIENT_COMMIT T_CLIENT_ABORT T_CLIENT_ACK T_CLIENT_NACK
%token T_CLIENT_DISCONNECT T_CLIENT_CONNECT T_CLIENT_STOMP T_SERVER_CONNECTED
%token T_SERVER_MESSAGE T_SERVER_RECEIPT T_SERVER_ERROR T_NULL T_LF T_CR T_EOL
%token T_COLON T_OCTET T_SPECIAL

%union {
    stomp_node_t node;
}

/* Map tokens and non-terminals to fiels in the yylval union. */
/* %type <node> factor term exp */

%%
expression     : frame { /* stomp_frame_root = $1; */ }
               ;

frame          : frame_command
                 frame_command
                 T_EOL
                 frame_octet
                 T_NULL
                 frame_eol
               ;

frame_command  : command T_EOL
               ;

frame_header   : header T_EOL
               | header T_EOL frame_header
               ;

frame_octet    : T_OCTET
               | T_OCTET frame_octet
               ;

frame_eol      : T_EOL
               | T_EOL frame_eol
               ;

command        : client_command 
               | server_command
               ;

client_command : T_CLIENT_SEND
               | T_CLIENT_SUBSCRIBE
               | T_CLIENT_UNSUBSCRIBE
               | T_CLIENT_BEGIN
               | T_CLIENT_COMMIT
               | T_CLIENT_ABORT
               | T_CLIENT_ACK
               | T_CLIENT_NACK
               | T_CLIENT_DISCONNECT
               | T_CLIENT_CONNECT
               | T_CLIENT_STOMP
               ;

server_command : T_SERVER_CONNECTED
               | T_SERVER_MESSAGE
               | T_SERVER_RECEIPT
               | T_SERVER_ERROR
               ;

header         : header_name T_COLON header_value
               ;

header_name    : T_SPECIAL
               ;

header_value   : header_name
               | header_name header_value
               ;
%%
