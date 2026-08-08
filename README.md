# AHelper

## Tools for Sustainable Inference Arch Linux Setups


`ahelper` is an application to facilitate customization of Arch Linux
installations. Arch Linux is popular because it enables one to create their own
minimal operating system with only the software they need. This saves computer
resources.

Arch Linux is typically configured via text files formatted for different
specification schemes, which becomes easy for experts with practice, but is
insurmountable for beginners, even with extensive programming experience in data
science, for example.

This repository collects scripts, github repositories, build instructions, and
similar computational artifacts that I have found useful for installing and
configuring Arch Linux.

`ahelper` seeks to ease the learning curve somewhat by providing distilled
customization commands to simplify the user experience but maintaining the
minimalist spirit. I imagine the target audience as those with general
programming experience, but who are beginners working with operating systems and
_systems-level_ programming in general.




### Official packages and alternatives

Official packages are preferred by `ahelper`, but many are not available for ARM
processor architectures. Our Sustainable Inference hardware products prefer ARM
to the more common and widely supported, but less efficient, x86.

At our current development-stage v0.1 we prefer ARM compatibility over official
`pacman` packages. If we do not use an official package where one is available,
that is because we stopped at what worked for ARM and moved on.



## The Types of Help That `ahelper` Provides

1. Install groups of related packages reliably whether ARM or x86. For
example in the base spec's [`rstats` block](base_), a `repo` is given for the R language
itself because the official sources have `r` for ARM and x86. However, no repo
exists in the official sources, including the user-driven AUR, for R essentials
RStudio and Quarto, both are Posit products. `ahelper` automates installing all
three on ARM and x86.
2. Configure system settings, including fetching packages if necessary. This
includes things like a `ahelper wifi`, a wrapper for connecting to wifi via
`iwctl`, or `ahelper memory` to be walked through memory configuration and best
practices in Arch Linux.

