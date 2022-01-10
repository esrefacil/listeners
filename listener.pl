#!/usr/bin/env perl

use warnings;
use strict;

use IO::Socket::INET;

# Autoflush stdout
$| = 1;

my $listener = new IO::Socket::INET (Listen    => 1,
                                     LocalAddr => '0.0.0.0',
                                     LocalPort => '8888',
                                     Proto     => 'tcp');

my $client_socket = $listener->accept();

while (1) {
  my $data = "";
  $client_socket->recv($data, 1024);
  print "$data";
  if ($data eq "") {
    last;
  }
}
shutdown($client_socket, 1);
