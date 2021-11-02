class Authorperm {
  const Authorperm(this.author, this.permlink);

  final String author;
  final String permlink;

  factory Authorperm.parse(String authorperm) {
    final parts = authorperm.split('/');
    return Authorperm(
        parts[0].startsWith('@') ? parts[0].substring(1) : parts[0], parts[1]);
  }
}
