bool nullOrEmpty(dynamic value) {
  if (value == null ||
      value.toString().trim().isEmpty ||
      value.toString() == 'null' ||
      value.toString() == '{}' ||
      (value is List && value.isEmpty == true)) return true;
  return false;
}

bool notNullorEmpty(dynamic value) {
  return !nullOrEmpty(value);
}

mixin ValidatorHelper {}
