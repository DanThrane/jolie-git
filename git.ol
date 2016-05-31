include "git.iol"
include "console.iol"
include "exec.iol"

execution { concurrent }

inputPort Git {
    Interfaces: GitIface
    Location: "local"
}

main
{
    [addRemote(req)(resp) {
        process = "git";
        with (process) {
            .args[0] = "remote";
            .args[1] = "add";
            .args[2] = req.name;
            .args[3] = req.url;
            .workingDirectory = req.directory
        };

        exec@Exec(process)(result);
        resp = result.exitCode
    }]

    [checkoutBranch(req)(resp) {
        process = "git";
        with (process) {
            .args[0] = "checkout";
            .args[1] = "-b";
            .args[2] = req.branch;
            .workingDirectory = req.directory
        };

        exec@Exec(process)(result);
        resp = result.exitCode
    }]

    [removeRemote(req)(resp) {
        process = "git";
        with (process) {
            .args[0] = "remote";
            .args[1] = "remove";
            .args[2] = req.name;
            .workingDirectory = req.directory
        };

        exec@Exec(process)(result);
        resp = result.exitCode
    }]

    [cloneRepo(req)(resp) {
        process = "git";
        with (process) {
            .args[0] = "clone";
            .args[1] = req.uri;
            .args[2] = req.directory
        };
        
        exec@Exec(process)(result);
        resp = result.exitCode
    }]

    [initRepo(req)(resp) {
        process = "git";
        with (process) {
            .args[0] = "init";
            .workingDirectory = req.directory
        };
        
        exec@Exec(process)(result);
        resp = result.exitCode
    }]

    [pull(req)(resp) {
        process = "git";
        with (process) {
            .args[0] = "pull";
            .args[1] = req.remote;
            .args[2] = req.branch;
            .workingDirectory = req.directory
        };

        exec@Exec(process)(result);
        resp = result.exitCode
    }]

    [push(req)(resp) {
        process = "git";
        with (process) {
            .args[0] = "push";
            .args[1] = req.remote;
            .args[2] = req.branch;
            .workingDirectory = req.directory
        };

        exec@Exec(process)(result);
        resp = result.exitCode
    }]

    [checkout(req)(resp) {
        process = "git";
        with (process) {
            .args[0] = "checkout";
            .args[1] = req.startPoint;
            .workingDirectory = req.directory
        };

        exec@Exec(process)(result);
        resp = result.exitCode
    }]

    [addAndCommit(req)(resp) {
        process = "git";
        with (process) {
            .args[0] = "add";
            .args[1] = "-A";
            .args[2] = ":/";
            .workingDirectory = req.directory
        };

        exec@Exec(process)(result);
        
        if (result.exitCode != 0) {
            resp = result.exitCode
        } else {
            process = "git";

            with (process) {
                .args[0] = "commit";
                .args[1] = "-m";
                .args[2] = req.message
            };

            exec@Exec(process)(result);
            resp = result.exitCode
        }
    }]

    [getCommitHash(request)(response) {
        process = "git";
        with (process) {
            .args[0] = "log";
            .args[1] = "-n";
            .args[2] = "1";
            .args[3] = request.branch;
            .args[4] = "--pretty=format:%H";
            .workingDirectory = request.directory
        };
        
        exec@Exec(process)(result);
        if (result.exitCode == 0) {
            response = result
        } else {
            response = null
        }
    }]

}
