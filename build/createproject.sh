#!/usr/bin/env bash

#Generate a new project from your HTML5 Boilerplate repo clone
#by: Rick Waldron & Michael Cetrulo


##first run
# $ cd  html5-boilerplate/build
# $ chmod +x createproject.sh && ./createproject.sh [new_project]

##usage
# $ cd  html5-boilerplate/build
# $ ./createproject.sh [new_project]

#
# If [new_project] is not specified the user we will prompted to enter it.
#
# The format of [new_project] should ideally be lowercase letters with no
# spaces as it represents the directory name that your new project will live
# in.
#
# If the new project is specified as just a name ( "foo" ) then the path
# will be a sibling to html5-boilerplate's directory.
#
# If the new project is specified with an absolute path ( "/home/user/foo" )
# that path will be used.
#

# find project root (also ensure script is ran from within repo)
src=$1

if [ $# -eq 2 ]
then
    # get a name for new project from command line arguments
    name="$2"
fi

# get a name for new project from input
while [[ -z $name ]]
do
    echo "To create a new html5-boilerplate project, enter a new directory name:"
    read name || exit
done

if [[ "$name" = /* ]]
then
    dst=$name
else
    dst="$PWD/$name"
fi

if [[ -d $dst ]]
then
    echo "$dst exists"
else
    #create new project
    mkdir -p -- "$dst" || exit 1

    #success message
    echo "Created Directory: $dst"

    cd -- "$src"

    cp -vr -- static build *.html *.xml *.txt *.png *.ico .htaccess "$dst"

    #success message
    echo "Created Project: $dst"
fi

read -p "Initiate SASS? (y/n): "
[ "$REPLY" != "y" ] || compass create "$dst" --syntax sass --sass-dir "src/sass" --css-dir "static/css" --javascripts-dir "static/js" --images-dir "static/images"