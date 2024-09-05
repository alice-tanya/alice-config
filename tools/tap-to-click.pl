#! /bin/env perl

use constant REX_SECTION_END => qr/^\s*EndSection\s*$/;
use constant REX_TP_OPT => qr/^\s*Option "Tapping" "on"\s*$/;
use constant REX_PREVIOUS_SPACE => qr/^(\s+)/;
use constant TP_OPT => 'Option "Tapping" "on"';
use constant TOUCHPAD_CONTENT => <<EOF;

Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "NaturalScrolling" "on"
        Option "Tapping" "on"
EndSection

EOF

sub add_tp_opt {
  my $fp = $_[0];
  if (! -e $fp) {
    open(my $fh, ">>", $fp) or die "open file error: $?";
    print $fh TOUCHPAD_CONTENT;
    close $fh;
    return;
  }

  my ($space, $status, $is_set, @content) = ("", 0, 0, undef);
  open (my $fh, '+<',$fp) or die "open file error: $?";
  while (my $lin = <$fh>) {
    $is_set = 1 if $lin =~ REX_TP_OPT;
    if ($lin =~ REX_SECTION_END && $is_set != 1) {
      push @content, $space.TP_OPT."\n";
      $is_set = 0;
    }
    ($space) = $lin =~ REX_PREVIOUS_SPACE;
    push @content, $lin;
  }

  seek ($fh, 0, 0);
  print $fh @content;
  close $fh;
}

add_tp_opt "/etc/X11/xorg.conf.d/90-touchpad.conf";
add_tp_opt "/usr/share/X11/xorg.conf.d/90-touchpad.conf";
add_tp_opt "/usr/local/share/X11/xorg.conf.d/90-touchpad.conf";
