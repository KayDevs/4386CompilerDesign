#include "symbol.h"
struct symrec *sym_table = NULL;
extern const char* enumStrings[2];
void add_symbol(enum types type, char *name) {
  printf("adding %s of type %s...\n", name, enumStrings[(int)type]);
  struct symrec *entry = sym_table;
  if(entry != NULL) {
    while(entry->next != NULL) {
      entry = entry->next;
    }
    entry->next = malloc(sizeof(struct symrec));
    entry->next->name = strdup(name);
    entry->next->type = type;
    entry->next->next = NULL;
  } else {
    entry = malloc(sizeof(struct symrec));
    entry->name = strdup(name);
    entry->type = type;
    entry->next = NULL;
  }
  printf("added.\n");
}
int set_symbol(char *name, int value) {
  struct symrec *entry = sym_table;
  while(entry != NULL) {
    if(strcmp(entry->name, name) == 0) {
      if(entry->type == INT_VAR_T) {
	entry->value.integer = value;
      } else {
	entry->value.boolean = value;
      }
      return 0;
    }
    entry = entry->next;
  }
  /*symbol doesn't exist*/
  return 1;
}
int symbol_exists(char *name) {
  struct symrec *entry = sym_table;
  while(entry != NULL) {
    if(strcmp(entry->name, name) == 0) {
      return 1;
    }
    entry = entry->next;
  }
  return 0;
}
