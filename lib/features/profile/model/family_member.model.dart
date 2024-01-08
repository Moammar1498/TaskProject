// ignore_for_file: public_member_api_docs, sort_constructors_first
class FamilyMember {
  final String? fullName;
  final String? relation;
  final String? phone;
  final String? birthdate;
  final String? gender;
  final String? photoUrl;
  FamilyMember({
    this.fullName,
    this.relation,
    this.phone,
    this.birthdate,
    this.gender,
    this.photoUrl,
  });

  FamilyMember copyWith({
    String? fullName,
    String? relation,
    String? phone,
    String? birthdate,
    String? gender,
    String? photoUrl,
  }) {
    return FamilyMember(
      fullName: fullName ?? this.fullName,
      relation: relation ?? this.relation,
      phone: phone ?? this.phone,
      birthdate: birthdate ?? this.birthdate,
      gender: gender ?? this.gender,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
