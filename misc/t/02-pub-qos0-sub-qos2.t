#!/usr/bin/perl
use warnings;
use strict;
use FindBin;
use lib $FindBin::Bin;
use Tester;
Tester->run(\*DATA);

__DATA__
{
 "stream" :
 [
  { "action" : "connect" },
  {
   "action" : "subscribe", "arguments" : { "qos" : 2 },
   "cvname" : "subscribe-qos0",
   "result" : "2"
  },
  { "action" : "publish", "arguments" : { "message" : "just testing" } },
  {
   "action" : "wait", "for" : "subscribe-qos0",
   "result" : { "topic" : "%topicpid%", "message" : "just testing" }
  }
 ],
 "log" :
 [
  "> Connect/at-most-once MQIsdp/3/%testname% ",
  "< ConnAck/at-most-once Connection Accepted ",
  "> Subscribe/at-least-once 1 %topicpid%/exactly-once ",
  "< SubAck/at-most-once 1/exactly-once ",
  "> Publish/at-most-once %topicpid% \n  6a 75 73 74 20 74 65 73 74 69 6e 67              just testing",
  "< Publish/at-most-once %topicpid% \n  6a 75 73 74 20 74 65 73 74 69 6e 67              just testing",
  "> Disconnect/at-most-once"
 ]
}
