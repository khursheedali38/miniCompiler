struct sr{
	char *name ;
	char type[10] ;
	struct sr *next ;
};
//sr symbol record
//st symbol
extern int scope_count ;
typedef struct sr sr ;
sr *st = (sr *)0 ;
sr *putsym() ;
sr *getsym() ;
sr *putsym(char *sym_name, int sym_type){
	char type[10] ;
	switch(sym_type){
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
	sr *ptr;
	ptr=(sr *)malloc(sizeof(sr));
	ptr->name=(char *)malloc(strlen(sym_name)+1);
	strcpy(ptr->name,sym_name);
	strcpy(ptr->type,type);
	ptr->next=(struct sr *)st;
	st=ptr;
	return ptr;

}

sr *getsym(char *sym_name)
{
	sr *ptr;
	for(ptr=st;ptr!=(sr *)0;ptr=(sr *)ptr->next)
	if(strcmp(ptr->name,sym_name)==0 && scope_count <2)
	return ptr;
	return 0;
}
