#include "m_pd.h"  
extern char* generateWord();

static t_class *mniak_class;  
 
typedef struct _mniak {  
  t_object x_obj;
} t_mniak;  
 
void mniak_bang(t_mniak *x)  
{
  (void)x; // silence unused variable warning
  post(generateWord());
}  
 
void *mniak_new(void)  
{  
  t_mniak *x = (t_mniak *)pd_new(mniak_class);  
  return (void *)x;  
}  
 
void mniak_setup(void) {  
  mniak_class = class_new(gensym("mniak"),  
    (t_newmethod)mniak_new, NULL,
    sizeof(t_mniak), CLASS_DEFAULT, 0);  
  class_addbang(mniak_class, mniak_bang);  
}
