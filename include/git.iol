type CloneRequest: void {
    .uri: string
    .directory: string
}

type InitRequest: void {
    .directory: string
}

type PullRequest: void {
    .directory: string
    .remote: string
    .branch: string
}

type PushRequest: void {
    .directory: string
    .remote: string
    .branch: string
}

type CheckoutRequest: void {
    .directory: string
    .startPoint: string
}

type CheckoutBranchRequest: void {
    .directory: string
    .branch: string
}

type AddAndCommitRequest: void {
    .directory: string
    .message: string
}

type AddRemoteRequest: void {
    .directory: string
    .name: string
    .url: string
}

type RemoveRemoteRequest: void {
    .directory: string
    .name: string
}

type CommitHashRequest: void {
    .directory: string
    .branch: string
}

interface GitIface {
  RequestResponse: 
    cloneRepo(CloneRequest)(int),
    initRepo(InitRequest)(int),
    pull(PullRequest)(int),
    push(PushRequest)(int),
    checkout(CheckoutRequest)(int),
    addAndCommit(AddAndCommitRequest)(int),
    addRemote(AddRemoteRequest)(int),
    removeRemote(RemoveRemoteRequest)(int),
    checkoutBranch(CheckoutBranchRequest)(int),
    getCommitHash(CommitHashRequest)(string)
}
