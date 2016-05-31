include "git.iol"

outputPort Git {
    Interfaces: GitIface
}

embedded {
    Jolie:
        "git.ol" in Git
}
