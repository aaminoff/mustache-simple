# NAME

Mustache::Simple - A simple Mustach Renderer

See [http://mustache.github.com/](http://mustache.github.com/).

# VERSION

This document describes Mustache::Simple version 0.9.0

# SYNOPSIS

A typical Mustache template:

    my $template = <<EOT;
Hello {{name}}
You have just won ${{value}}!
{{#in_ca}}
Well, ${{taxed_value}}, after taxes.
{{/in_ca}}
EOT

Given the following hashref:

    my $context = {
	name => "Chris",
	value => 10000,
	taxed_value => 10000 - (10000 * 0.4),
	in_ca => 1
    };

Will produce the following:

    Hello Chris
    You have just won $10000!
    Well, $6000, after taxes.

using the following code:

    my $tache = new Mustache::Simple(
	throw => 1
    );
    my $output = $tache->render($template, $context);

# DESCRIPTION

Mustache can be used for HTML, config files, source code - anything. It works
by expanding tags in a template using values provided in a hash or object.

There are no if statements, else clauses, or
for loops. Instead there are only tags. Some tags are replaced with a value,
some nothing, and others a series of values.

This is a simple perl implementation of the Mustache rendering.  It has
a single class method, new() to obtain an object and a single instance
method render() to convert the template and the hashref into the final
output.

## Rationale

I wanted a simple rendering tool for Mustache that did not require any
subclassing.  It has currently been tested only against the list of examples on
the mustache manual page: [http://mustache.github.com/mustache.5.html](http://mustache.github.com/mustache.5.html) and
the mustache demo page: [http://mustache.github.com/\#demo](http://mustache.github.com/\#demo).

# METHODS

## Creating a new Mustache::Simple object

- new

        my $tache = new Mustache::Simple(%options)

### Parameters:

- path

    The path from which to load templates and partials.

    Default: '.'

- extension

    The extension to add to filenames when reading them off disk. The
    '.' should not be included as this will be added automatically.

    Default: 'mustache'

- throw

    If set to a true value, Mustache::Simple will croak when there
    is no key in the context hash for a given tag.

    Default: undef

- partial

    This may be set to a subroutine to be called to generate the
    filename or the template for a partial.  If it is not set, partials
    will be loaded using the same parameters as render().

    Default: undef

## Configuration Methods

The configuration methods match the %options array thay may be passed
to new().

Each option may be called with a non-false value to set the option
and will return the new value.  If called without a value, it will return
the current value.

- path()

        $tache->path('/some/new/template/path');
        my $path = $tache->path;	# defaults to '.'
- extension()

        $tache->extension('html');
        my $extension = $tache->extension;	# defaults to 'mustache'
- throw()

        $tache->throw(1);
        my $throwing = $tache->throw;	# defaults to undef
- partial()

        $tache->partial(\&resolve_partials)
        my $partial = $tache->partial	# defaults to undef

## Instance methods

- read\_file()

        my $template = read_file('templatefile');

    You will not usually need to call this directly as it's called by
    ["render"](#render) to load the file.  If it is passed a string that looks like
    a template (i.e. has {{ in it) it simply returns it.  Similarly, if,
    after prepending the path and adding the suffix, it cannot load the file,
    it simply returns the original string.

- render()

        my $context = {
    	"name" => "Chris",
    	"value" => 10000,
    	"taxed_value" => 10000 - (10000 * 0.4),
    	"in_ca" => true
        }
        my $html = $tache->render('templatefile', $context);

    This is the main entry-point for rendering templates.  It can be passed
    either a full template or path to a template file.  See ["read\_file"](#read\_file)
    for details of how the file is loaded.  It must also be passed a hashref
    containing the main context.

    In callbacks (sections like ` {{#this}} ` with a subroutine in the context),
    you may call render on the passed string and the current context will be
    remembered.  For example:

        {
    	name => "Willy",
    	wrapped => sub {
    	    my $text = shift;
    	    chomp $text;
    	    return "<b>" . $tache->render($text) . "</b>\n";
    	}
        }

    Alternatively, you may pass in an entirely new context when calling
    render() from a callback.

# EXPORTS

Nothing.

# SEE ALSO

[Template::Mustache](http://search.cpan.org/perldoc?Template::Mustache) - a much more complex module that is
designed to be subclassed for each template.

# AUTHOR INFORMATION

Cliff Stanford `<cliff@may.be>`

# LICENCE AND COPYRIGHT

Copyright © 2012, Cliff Stanford `<cliff@may.be>`. All rights reserved.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.
