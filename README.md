# onCourseDocs
[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fishgroup%2FonCourseDocs.svg?type=shield)](https://app.fossa.com/projects/git%2Bgithub.com%2Fishgroup%2FonCourseDocs?ref=badge_shield)

Documentation for all parts of the onCourse student management system

This is the source code for the documentation which can be found here:

* https://www.ish.com.au/onCourse/doc/manual/
* https://www.ish.com.au/onCourse/doc/web/
* https://www.ish.com.au/onCourse/doc/design/
* https://www.ish.com.au/onCourse/doc/dsl/
* https://www.ish.com.au/onCourse/doc/release-notes/


## Building the docs

The documenation is built using gradle, so all you need to have installed on your machine is Java 11 or higher. Then run:

    ./gradlew asciidoctor

You can also build individual documentation projects with something like

    ./gradlew design:asciidoctor


## Editing

We recommend Intellij with the Asciidoc plugin installed to work on this documentation.


## License

This work is licensed under a Creative Commons Attribution 4.0 International License.


[![FOSSA Status](https://app.fossa.com/api/projects/git%2Bgithub.com%2Fishgroup%2FonCourseDocs.svg?type=large)](https://app.fossa.com/projects/git%2Bgithub.com%2Fishgroup%2FonCourseDocs?ref=badge_large)

## Proprietary parts

The DSL documentation also has a dependency on some swagger API files which are not available under an open source license yet. We are working on making that available.