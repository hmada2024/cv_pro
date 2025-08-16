// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cv_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCVHistoryCollection on Isar {
  IsarCollection<CVHistory> get cVHistorys => this.collection();
}

const CVHistorySchema = CollectionSchema(
  name: r'CVHistory',
  id: 2914229755692706041,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'displayName': PropertySchema(
      id: 1,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'education': PropertySchema(
      id: 2,
      name: r'education',
      type: IsarType.objectList,
      target: r'Education',
    ),
    r'experiences': PropertySchema(
      id: 3,
      name: r'experiences',
      type: IsarType.objectList,
      target: r'Experience',
    ),
    r'languages': PropertySchema(
      id: 4,
      name: r'languages',
      type: IsarType.objectList,
      target: r'Language',
    ),
    r'personalInfo': PropertySchema(
      id: 5,
      name: r'personalInfo',
      type: IsarType.object,
      target: r'PersonalInfo',
    ),
    r'references': PropertySchema(
      id: 6,
      name: r'references',
      type: IsarType.objectList,
      target: r'Reference',
    ),
    r'skills': PropertySchema(
      id: 7,
      name: r'skills',
      type: IsarType.objectList,
      target: r'Skill',
    )
  },
  estimateSize: _cVHistoryEstimateSize,
  serialize: _cVHistorySerialize,
  deserialize: _cVHistoryDeserialize,
  deserializeProp: _cVHistoryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'PersonalInfo': PersonalInfoSchema,
    r'Experience': ExperienceSchema,
    r'Skill': SkillSchema,
    r'Language': LanguageSchema,
    r'Education': EducationSchema,
    r'Reference': ReferenceSchema
  },
  getId: _cVHistoryGetId,
  getLinks: _cVHistoryGetLinks,
  attach: _cVHistoryAttach,
  version: '3.1.0+1',
);

int _cVHistoryEstimateSize(
  CVHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.displayName.length * 3;
  bytesCount += 3 + object.education.length * 3;
  {
    final offsets = allOffsets[Education]!;
    for (var i = 0; i < object.education.length; i++) {
      final value = object.education[i];
      bytesCount += EducationSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.experiences.length * 3;
  {
    final offsets = allOffsets[Experience]!;
    for (var i = 0; i < object.experiences.length; i++) {
      final value = object.experiences[i];
      bytesCount += ExperienceSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.languages.length * 3;
  {
    final offsets = allOffsets[Language]!;
    for (var i = 0; i < object.languages.length; i++) {
      final value = object.languages[i];
      bytesCount += LanguageSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 +
      PersonalInfoSchema.estimateSize(
          object.personalInfo, allOffsets[PersonalInfo]!, allOffsets);
  bytesCount += 3 + object.references.length * 3;
  {
    final offsets = allOffsets[Reference]!;
    for (var i = 0; i < object.references.length; i++) {
      final value = object.references[i];
      bytesCount += ReferenceSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.skills.length * 3;
  {
    final offsets = allOffsets[Skill]!;
    for (var i = 0; i < object.skills.length; i++) {
      final value = object.skills[i];
      bytesCount += SkillSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _cVHistorySerialize(
  CVHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeString(offsets[1], object.displayName);
  writer.writeObjectList<Education>(
    offsets[2],
    allOffsets,
    EducationSchema.serialize,
    object.education,
  );
  writer.writeObjectList<Experience>(
    offsets[3],
    allOffsets,
    ExperienceSchema.serialize,
    object.experiences,
  );
  writer.writeObjectList<Language>(
    offsets[4],
    allOffsets,
    LanguageSchema.serialize,
    object.languages,
  );
  writer.writeObject<PersonalInfo>(
    offsets[5],
    allOffsets,
    PersonalInfoSchema.serialize,
    object.personalInfo,
  );
  writer.writeObjectList<Reference>(
    offsets[6],
    allOffsets,
    ReferenceSchema.serialize,
    object.references,
  );
  writer.writeObjectList<Skill>(
    offsets[7],
    allOffsets,
    SkillSchema.serialize,
    object.skills,
  );
}

CVHistory _cVHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CVHistory(
    createdAt: reader.readDateTime(offsets[0]),
    displayName: reader.readString(offsets[1]),
    education: reader.readObjectList<Education>(
          offsets[2],
          EducationSchema.deserialize,
          allOffsets,
          Education(),
        ) ??
        [],
    experiences: reader.readObjectList<Experience>(
          offsets[3],
          ExperienceSchema.deserialize,
          allOffsets,
          Experience(),
        ) ??
        [],
    languages: reader.readObjectList<Language>(
          offsets[4],
          LanguageSchema.deserialize,
          allOffsets,
          Language(),
        ) ??
        [],
    personalInfo: reader.readObjectOrNull<PersonalInfo>(
          offsets[5],
          PersonalInfoSchema.deserialize,
          allOffsets,
        ) ??
        PersonalInfo(),
    references: reader.readObjectList<Reference>(
          offsets[6],
          ReferenceSchema.deserialize,
          allOffsets,
          Reference(),
        ) ??
        [],
    skills: reader.readObjectList<Skill>(
          offsets[7],
          SkillSchema.deserialize,
          allOffsets,
          Skill(),
        ) ??
        [],
  );
  object.id = id;
  return object;
}

P _cVHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTime(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readObjectList<Education>(
            offset,
            EducationSchema.deserialize,
            allOffsets,
            Education(),
          ) ??
          []) as P;
    case 3:
      return (reader.readObjectList<Experience>(
            offset,
            ExperienceSchema.deserialize,
            allOffsets,
            Experience(),
          ) ??
          []) as P;
    case 4:
      return (reader.readObjectList<Language>(
            offset,
            LanguageSchema.deserialize,
            allOffsets,
            Language(),
          ) ??
          []) as P;
    case 5:
      return (reader.readObjectOrNull<PersonalInfo>(
            offset,
            PersonalInfoSchema.deserialize,
            allOffsets,
          ) ??
          PersonalInfo()) as P;
    case 6:
      return (reader.readObjectList<Reference>(
            offset,
            ReferenceSchema.deserialize,
            allOffsets,
            Reference(),
          ) ??
          []) as P;
    case 7:
      return (reader.readObjectList<Skill>(
            offset,
            SkillSchema.deserialize,
            allOffsets,
            Skill(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cVHistoryGetId(CVHistory object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _cVHistoryGetLinks(CVHistory object) {
  return [];
}

void _cVHistoryAttach(IsarCollection<dynamic> col, Id id, CVHistory object) {
  object.id = id;
}

extension CVHistoryQueryWhereSort
    on QueryBuilder<CVHistory, CVHistory, QWhere> {
  QueryBuilder<CVHistory, CVHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CVHistoryQueryWhere
    on QueryBuilder<CVHistory, CVHistory, QWhereClause> {
  QueryBuilder<CVHistory, CVHistory, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension CVHistoryQueryFilter
    on QueryBuilder<CVHistory, CVHistory, QFilterCondition> {
  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> createdAtEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> createdAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> createdAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> displayNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      displayNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> displayNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> displayNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      displayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> displayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> displayNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> displayNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      educationLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'education',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> educationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'education',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      educationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'education',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      educationLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'education',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      educationLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'education',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      educationLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'education',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      experiencesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'experiences',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      experiencesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'experiences',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      experiencesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'experiences',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      experiencesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'experiences',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      experiencesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'experiences',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      experiencesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'experiences',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      languagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'languages',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> languagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'languages',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      languagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'languages',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      languagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'languages',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      languagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'languages',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      languagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'languages',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      referencesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'references',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      referencesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'references',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      referencesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'references',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      referencesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'references',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      referencesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'references',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      referencesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'references',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> skillsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skills',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> skillsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skills',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> skillsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skills',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      skillsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skills',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition>
      skillsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skills',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> skillsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'skills',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension CVHistoryQueryObject
    on QueryBuilder<CVHistory, CVHistory, QFilterCondition> {
  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> educationElement(
      FilterQuery<Education> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'education');
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> experiencesElement(
      FilterQuery<Experience> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'experiences');
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> languagesElement(
      FilterQuery<Language> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'languages');
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> personalInfo(
      FilterQuery<PersonalInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'personalInfo');
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> referencesElement(
      FilterQuery<Reference> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'references');
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterFilterCondition> skillsElement(
      FilterQuery<Skill> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'skills');
    });
  }
}

extension CVHistoryQueryLinks
    on QueryBuilder<CVHistory, CVHistory, QFilterCondition> {}

extension CVHistoryQuerySortBy on QueryBuilder<CVHistory, CVHistory, QSortBy> {
  QueryBuilder<CVHistory, CVHistory, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterSortBy> sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterSortBy> sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }
}

extension CVHistoryQuerySortThenBy
    on QueryBuilder<CVHistory, CVHistory, QSortThenBy> {
  QueryBuilder<CVHistory, CVHistory, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterSortBy> thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterSortBy> thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CVHistory, CVHistory, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension CVHistoryQueryWhereDistinct
    on QueryBuilder<CVHistory, CVHistory, QDistinct> {
  QueryBuilder<CVHistory, CVHistory, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<CVHistory, CVHistory, QDistinct> distinctByDisplayName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }
}

extension CVHistoryQueryProperty
    on QueryBuilder<CVHistory, CVHistory, QQueryProperty> {
  QueryBuilder<CVHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CVHistory, DateTime, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<CVHistory, String, QQueryOperations> displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<CVHistory, List<Education>, QQueryOperations>
      educationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'education');
    });
  }

  QueryBuilder<CVHistory, List<Experience>, QQueryOperations>
      experiencesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'experiences');
    });
  }

  QueryBuilder<CVHistory, List<Language>, QQueryOperations>
      languagesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'languages');
    });
  }

  QueryBuilder<CVHistory, PersonalInfo, QQueryOperations>
      personalInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'personalInfo');
    });
  }

  QueryBuilder<CVHistory, List<Reference>, QQueryOperations>
      referencesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'references');
    });
  }

  QueryBuilder<CVHistory, List<Skill>, QQueryOperations> skillsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'skills');
    });
  }
}
