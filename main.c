#include <stdio.h>
#include <string.h>
#include <unicode/uloc.h>
#include <unicode/ustring.h>

int main(int argc, char* argv[]) {
  UErrorCode status;

  status = U_ZERO_ERROR;
  uloc_setDefault(ULOC_GERMAN, &status);
  if (U_FAILURE(status)) {
    printf("uloc_setDefault failed!\n");
    return 1;
  }

  char str_utf8_original[] = u8"Das Kind überquerte die Straße.";
  printf("Original:  %s\n", str_utf8_original);

  UChar str_utf16_original[128];
  int32_t str_utf16_original_len;
  status = U_ZERO_ERROR;
  u_strFromUTF8(
    str_utf16_original,
    128,
    &str_utf16_original_len,
    str_utf8_original,
    strlen(str_utf8_original),
    &status
  );
  if (U_FAILURE(status)) {
    printf("u_strFromUTF8 failed!\n");
    return 1;
  }

  UChar str_utf16_upper[128];
  status = U_ZERO_ERROR;
  int32_t str_utf16_upper_len = u_strToUpper(
    str_utf16_upper,
    128,
    str_utf16_original,
    str_utf16_original_len,
    NULL,
    &status
  );
  if (U_FAILURE(status)) {
    printf("u_strToUpper failed!\n");
    return 1;
  }

  char str_utf8_upper[128];
  int32_t str_utf8_upper_len;
  status = U_ZERO_ERROR;
  u_strToUTF8(
    str_utf8_upper,
    128,
    &str_utf8_upper_len,
    str_utf16_upper,
    str_utf16_upper_len,
    &status
  );
  if (U_FAILURE(status)) {
    printf("u_strToUTF8 failed!\n");
    return 1;
  }

  printf("Uppercase: %s\n", str_utf8_upper);
  return 0;
}
