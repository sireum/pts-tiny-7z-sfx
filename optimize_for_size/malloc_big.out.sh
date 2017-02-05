<t perl -wne 'our %h; our $total_alloc; our $usage; our $max_usage; BEGIN { $max_usage = 0 } if (m@^DYNAMIC FREE \(nil\)$@) {} elsif (m@^DYNAMIC ALLOC (\d+) = (0x\w+)$@) { $h{$2} = $1; print if $1 > 9999; $total_alloc += 16 + $1; $usage += 16 + $1; $max_usage = $usage if $max_usage < $usage; } elsif (m@^DYNAMIC FREE (0x\w+)$@) { die "xfree!\n" if !exists($h{$1}); chomp; print "$_ was $h{$1}\n" if $h{$1} > 9999; $usage -= 16 + $h{$1}; delete $h{$1} } else { print } END {print "STATS total_alloc = $total_alloc\n"; print "STATS final_usage = $usage\n"; print "STATS max_usage = $max_usage\n"}' >optimize_for_size/malloc_big.out
