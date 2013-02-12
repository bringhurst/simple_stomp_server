/* See the file "COPYING" for the full license governing this code. */

#include "config.h"
#include "stompd.h"

#include <getopt.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <inttypes.h>

/**
 * Print the current version.
 */
void STOMPD_print_version()
{
    fprintf(stdout, "%s-%s <%s>\n", \
            PACKAGE_NAME, PACKAGE_VERSION, PACKAGE_URL);
}

/**
 * Print a usage message.
 */
void STOMPD_print_usage(char** argv)
{
    printf("usage: %s [c]\n", argv[0]);
}

int main(int argc, \
         char** argv)
{
    int c;
    int option_index = 0;

    STOMPD_debug_stream = stdout;

    struct STOMPD_config_t opts;

    /* By default, show info log messages. */
    opts.debug_level = STOMPD_LOG_DBG;

    /* By default, don't attempt any type of recursion. */
    opts.listen_port = STOMPD_DEFAULT_PORT;

    static struct option long_options[] = {
        {"debug"                , required_argument, 0, 'd'},
        {"port"                 , required_argument, 0, 'p'},
        {"help"                 , no_argument      , 0, 'h'},
        {"version"              , no_argument      , 0, 'v'},
        {0                      , 0                , 0, 0  }
    };

    /* Parse options */
    while((c = getopt_long(argc, argv, "d:p:hv", \
                           long_options, &option_index)) != -1) {
        switch(c) {

            case 'h':
                STOMPD_print_usage(argv);
                exit(EXIT_SUCCESS);
                break;

            case 'v':
                STOMPD_print_version();
                exit(EXIT_SUCCESS);
                break;

            case '?':
            default:

                if(optopt == 'd') {
                    STOMPD_print_usage(argv);
                    fprintf(stderr, "Option -%c requires an argument.\n", \
                            optopt);
                }
                else if(isprint(optopt)) {
                    STOMPD_print_usage(argv);
                    fprintf(stderr, "Unknown option `-%c'.\n", optopt);
                }
                else {
                    STOMPD_print_usage(argv);
                    fprintf(stderr,
                            "Unknown option character `\\x%x'.\n",
                            optopt);
                }

                exit(EXIT_FAILURE);
                break;
        }
    }

    /* TODO: stuff */

    exit(EXIT_SUCCESS);
}

/* EOF */
