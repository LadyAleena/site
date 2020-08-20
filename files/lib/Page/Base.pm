package Page::Base;
use v5.10.0;
use strict;
use warnings;
use Exporter qw(import);
our @EXPORT_OK = qw(page story passage convert_string);

use CGI::Carp qw(fatalsToBrowser);
use Cwd qw(cwd realpath);
use File::Basename;
use File::Spec;
use List::Util qw(max);

use Page::HTML qw(html style noscript nav main section list div anchor img input);
use Page::Line qw(line);
use Page::Link::Contact qw(contact_links);
use Page::Path qw(base_path);
use Page::Menu qw(base_menu);
use Page::Style qw(base_stylesheets);
use Util::Convert qw(idify textify);

my $full_path = realpath($0);
my $root_path = base_path('path');
my $root_link = base_path('link');

sub page {
  my (%opt) = @_;

  my $basename = basename($0);
  if ($opt{'uri'}) {
    $full_path = $root_path.$opt{'uri'};
  }
  my $relative_path = $full_path;
     $relative_path =~ s/^(?:$root_path\/|\/)//;

  my $page_heading = $opt{'heading'} && ref($opt{'heading'}) eq 'ARRAY' ? textify(@{$opt{'heading'}}, { html => 'yes' }) :
                     $opt{'heading'} ? textify($opt{'heading'}, { html => 'yes' }) :
                     $basename =~ /index/ ? textify((split(/\//, cwd))[-1]) : ucfirst textify($basename);;

  if ( $opt{'heading'} ) {
    my $file_title = $basename;
    my $opt_title = $opt{'heading'} && ref($opt{'heading'}) eq 'ARRAY' ? ${$opt{'heading'}}[0] : $opt{'heading'};
    $relative_path =~ s/$file_title/$opt_title/; # This regex sometimes does not work.
  }
  my $title = textify(join(' - ', ('Lady Aleena', map { ucfirst } grep { !/index/ } split(/\//, $relative_path))));

     $relative_path =~ s/\.\w+$//;
  my @relative_path_split = split(/\//,$relative_path);
  my $styles  = base_stylesheets(undef, "$root_path/files/css", \@relative_path_split, { 'full path' => $full_path });
  my $js      = File::Spec->abs2rel("$root_path/files/lib/myjs.js", $full_path);
  my $charset = $opt{'charset'} ? $opt{'charset'} : 'utf-8';
  my $menu    = base_menu($root_path, {
    'tab'   => 2,
    'color' => 0,
    'full'  => 0,
    'misc'  => 1,
    'selected'  => $opt{'selected'},
    'file menu' => $opt{'file menu'} ? $opt{'file menu'} : undef,
    'root path' => $root_path,
    'full path' => $opt{'uri'} ? $full_path : undef
  });

  my $main_id = idify($page_heading);
  html(0, {
    'lang' => 'en',
    'head' => {
      'title'    => $title,
      'links'    => $styles,
      'scripts'  => [
        { 'src' => $js }
      ],
      'meta'     => [
        {'charset' => $charset},
        {'name' => 'viewport', 'content' => 'width=device-width, initial-scale=1'}
      ],
      'noscript' => sub { style(3, 'li.closed ol, li.closed ul, li.closed dl {display:block;}') },
    },
    'body' => [
      sub {
        nav(2, sub {
          input(3, {
            'type'  => 'checkbox',
            'id'    => 'menu_collapse',
            'label' => ['Site menu', { 'for' => 'menu_collapse', 'title' => 'Click here for the site menu.' }],
            'place label' => 'after',
          });
          section(3, sub {
            div(4, sub {
              line(5, join("\n"." "x10, contact_links()))
            }, { 'id' => 'contacts_nav', 'title' => 'Ways to contact me' });
            list(4, 'u', $menu, { 'id' => 'site_menu' } );
          }, { 'id' => 'main_menu', 'title' => 'Site menu' });
        }, { 'id' => 'main_navigation' });
        main(2, sub {
          &{$opt{'code'}};
          if ($root_path =~ /fantasy/) {
            section(3, sub {
              div(4, '', { 'id' => 'disqus_thread'} );
              line(4, qq(<script>
              /* * * CONFIGURATION VARIABLES * * */
              var disqus_shortname = 'ladyaleena';
              var disqus_identifier = '$page_heading';

              /* * * DON'T EDIT BELOW THIS LINE * * */
              (function() {
                  var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
                  dsq.src = '//' + disqus_shortname + '.disqus.com/embed.js';
                  (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
              })();
              </script>));
                noscript(4, q(Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript" rel="nofollow">comments powered by Disqus</a>.));
            }, { 'heading' => [2, 'Comments', { 'class' => 'disqus', 'id' => 'Comments' }], 'class' => 'disqus' } );
          }
          div(3, sub {
            line(4, anchor('&#9650; to top', { 'href' => "#${main_id}_title", 'class' => 'to_top', 'title' => 'Back to top' }));
          }, { 'class' => 'to_top' });
        }, { 'id' => $main_id, 'heading' => [1, $page_heading, { 'id' => "${main_id}_heading", 'style' => $page_heading eq 'index' ? 'display: none' : undef }] });
        div(2, sub {
          line(3, anchor('&#9650; to top', { 'href' => "#title", 'class' => 'to_top', 'title' => 'Back to top' }));
        }, { 'class' => 'to_top' });
      },
      {
        'header' => [
          sub {
            div(3, sub {
              line(4, img({ 'src' => File::Spec->abs2rel("$root_path/files/images/avatar.jpg", $full_path), 'class' => 'avatar', 'alt' => "Lady Aleena's avatar", 'title' => "Lady Aleena's avatar" }));
            }, { id => 'avatar' });
            div(3, sub {
              line(4, anchor('Lady Aleena', { 'class' => 'home', 'href' => $root_link, 'title' => 'Home' }));
            }, { id => 'title' });
            div(3, sub {
              line(4, join("\n"." "x8, contact_links()))
            }, { 'id' => 'contacts', 'title' => 'Ways to contact me' });
            div(3, sub {
              line(4, anchor('About Lady Aleena', { 'href' => "$root_link?page=about", 'title' => 'About Lady Aleena and the site'}));
            }, { 'id' => 'about' });
          }, { 'id' => 'main_header'}
        ],
        'class' => $opt{'class'} ? $opt{'class'} : undef
      }
    ]
  });
}

=pod

=encoding utf8

=head1 AUTHOR

Lady Aleena

=head1 LICENSE AND COPYRIGHT

This module is free software; you can redistribute it and/or modify it under the same terms as Perl itself. See L<perlartistic>.

Copyright © 2020, Lady Aleena C<(aleena@cpan.org)>. All rights reserved.

=cut

1;