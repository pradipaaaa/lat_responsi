String? requiredValidator(String? value) {
  if ((value ?? '').trim().isEmpty) return 'Field ini wajib diisi.';
  return null;
}
