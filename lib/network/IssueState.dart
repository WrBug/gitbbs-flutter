enum IssueState { OPEN, ALL, CLOSED }

String toState(IssueState state) {
  switch (state) {
    case IssueState.OPEN:
      {
        return 'open';
      }
    case IssueState.ALL:
      {
        return 'all';
      }
    case IssueState.CLOSED:
      {
        return 'close';
      }
  }
  return 'all';
}
