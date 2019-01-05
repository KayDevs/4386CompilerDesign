#include "symbol.h"
void add_symbol(enum types type, char *name, int value) {
  struct symrec *entry = sym_table;
  while(entry != NULL) {
    entry = entry->next;
  }
  entry = malloc(sizeof(struct symrec));
  entry->name = strdup(name);
  entry->type = type;
  if(type == INT_VAR_T) {
    entry->value.integer = value;
  } else {
    entry->value.boolean = value;
  }
  entry->next = NULL;
}
