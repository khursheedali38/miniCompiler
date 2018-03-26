#define t_void	1
#define t_char	2
#define t_int	3
#define t_float	4
struct symrec
{
	char *name;
	char type[10];
	struct symrec *next;
};
extern int scope_count ;
typedef struct symrec symrec;
symrec *sym_table = (symrec *)0;
symrec *putsym();
symrec *getsym();
symrec *putsym(char *sym_name,int sym_type)
{
	char type[10];
	switch(sym_type)
	{
		case 1:
			strcpy(type,"void");
			break;
		case 2:
			strcpy(type,"char");
			break;
		case 3:
			strcpy(type,"int");
			break;
		case 4:
			strcpy(type,"float");
			break;
	}
	symrec *ptr;
	ptr=(symrec *)malloc(sizeof(symrec));
	ptr->name=(char *)malloc(strlen(sym_name)+1);
	strcpy(ptr->name,sym_name);
	strcpy(ptr->type,type);
	ptr->next=(struct symrec *)sym_table;
	sym_table=ptr;
	return ptr;
}
symrec *getsym(char *sym_name)
{
	symrec *ptr;
	for(ptr=sym_table;ptr!=(symrec *)0;ptr=(symrec *)ptr->next)
	if(strcmp(ptr->name,sym_name)==0 && scope_count <2)
	return ptr;
	return 0;
}
